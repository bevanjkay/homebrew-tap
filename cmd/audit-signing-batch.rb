# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "json"
require "open3"
require "tap"
require "timeout"

module Homebrew
  module Cmd
    class AuditSigningBatch < AbstractCommand
      DEFAULT_COUNT = T.let(20, Integer)
      DEFAULT_JOBS = T.let(5, Integer)
      DEFAULT_RESULTS_FILE = T.let(
        (Pathname.new(Dir.home)/".homebrew/audit_signing_results.json").freeze,
        Pathname,
      )
      FETCH_TIMEOUT_SECONDS = T.let(120, Integer)
      MAX_ERROR_LENGTH = T.let(500, Integer)
      DOWNLOADS_WARNING_THRESHOLD_BYTES = T.let(20 * 1024 * 1024 * 1024, Integer)
      ANSI_RESET = T.let("\e[0m", String)
      ANSI_GREEN = T.let("\e[32m", String)
      ANSI_RED = T.let("\e[31m", String)
      ANSI_YELLOW = T.let("\e[33m", String)
      ANSI_BLUE = T.let("\e[34m", String)
      ANSI_ORANGE = T.let("\e[38;5;214m", String)

      class TokenResult < T::Struct
        const :passed, T::Boolean
        const :error, T.nilable(String)
        const :failure_source, T.nilable(String)
        const :persist_result, T::Boolean
      end

      class Args < Homebrew::CLI::Args
        sig { returns(T.nilable(String)) }
        def count; end

        sig { returns(T.nilable(String)) }
        def jobs; end

        sig { returns(T.nilable(String)) }
        def results_file; end
      end

      cmd_args do
        usage_banner <<~EOS
          `audit-signing-batch` [`--count=`<n>] [`--jobs=`<n>] [`--results-file=`<path>]

          Audit the next batch of `homebrew/cask` casks with `brew audit --online --only=signing`.
          Results are cached as JSON and previously checked casks are skipped.
          Casks matching `font-*` are always skipped.
        EOS

        flag "--count=",
             description: "Number of unchecked casks to process. Defaults to 20."
        flag "--jobs=",
             description: "Number of concurrent fetch workers and audit workers. Defaults to 5."
        flag "--results-file=",
             description: "Path to the JSON results cache. Defaults to ~/.homebrew/audit_signing_results.json."

        named_args :none
      end

      sig { override.void }
      def run
        ENV["HOMEBREW_EVAL_ALL"] = "1"
        cmd_args = T.cast(args, Args)

        count = positive_integer_arg(cmd_args.count, flag: "--count", default: DEFAULT_COUNT)
        jobs = positive_integer_arg(cmd_args.jobs, flag: "--jobs", default: DEFAULT_JOBS)
        results_file = Pathname.new(cmd_args.results_file || DEFAULT_RESULTS_FILE.to_s).expand_path
        details_file = details_file_for(results_file)
        results = load_results(results_file)
        details = load_details(details_file)

        tokens = next_tokens(results: results, count: count)
        if tokens.empty?
          puts "No unchecked non-font casks found."
          return
        end

        audit_results = audit_batch(
          tokens:       tokens,
          jobs:         jobs,
          results:      results,
          results_file: results_file,
          details:      details,
          details_file: details_file,
        )

        unless $stdout.tty?
          tokens.each do |token|
            puts "#{token}: #{audit_results.fetch(token).passed}"
          end
        end

        report_failures(tokens: tokens, audit_results: audit_results, details: details)
        deprecate_audit_failures(tokens: tokens, audit_results: audit_results)
        report_downloads_cache_size
      end

      private

      sig { params(value: T.nilable(String), flag: String, default: Integer).returns(Integer) }
      def positive_integer_arg(value, flag:, default:)
        return default if value.blank?

        odie "#{flag} must be a positive integer." unless /\A[1-9]\d*\z/.match?(value)

        value.to_i
      end

      sig { params(results_file: Pathname).returns(T::Hash[String, T::Boolean]) }
      def load_results(results_file)
        return {} unless results_file.exist?

        parsed = JSON.parse(results_file.read)
        odie "Results file must contain a JSON object: #{results_file}" unless parsed.is_a?(Hash)

        parsed.each_with_object({}) do |(token, result), memo|
          memo[token.to_s] = result == true
        end
      rescue JSON::ParserError => e
        odie "Failed to parse results file #{results_file}: #{e.message}"
      end

      sig { params(results_file: Pathname, results: T::Hash[String, T::Boolean]).void }
      def save_results(results_file, results)
        results_file.dirname.mkpath
        results_file.write(JSON.pretty_generate(results.sort.to_h) << "\n")
      end

      sig { params(results_file: Pathname).returns(Pathname) }
      def details_file_for(results_file)
        if results_file.extname == ".json"
          results_file.sub_ext(".details.json")
        else
          Pathname.new("#{results_file}.details.json")
        end
      end

      sig { params(details_file: Pathname).returns(T::Hash[String, String]) }
      def load_details(details_file)
        return {} unless details_file.exist?

        parsed = JSON.parse(details_file.read)
        odie "Details file must contain a JSON object: #{details_file}" unless parsed.is_a?(Hash)

        parsed.each_with_object({}) do |(token, detail), memo|
          next if detail.blank?

          memo[token.to_s] = detail.to_s
        end
      rescue JSON::ParserError => e
        odie "Failed to parse details file #{details_file}: #{e.message}"
      end

      sig { params(details_file: Pathname, details: T::Hash[String, String]).void }
      def save_details(details_file, details)
        details_file.dirname.mkpath
        details_file.write(JSON.pretty_generate(details.sort.to_h) << "\n")
      end

      sig { params(results: T::Hash[String, T::Boolean], count: Integer).returns(T::Array[String]) }
      def next_tokens(results:, count:)
        Tap.fetch("homebrew/cask").cask_files
           .map { |path| File.basename(path, ".rb") }
           .sort
           .reject { |token| token.start_with?("font-") }
           .reject { |token| results.key?(token) }
           .first(count)
      end

      sig {
        params(tokens: T::Array[String], jobs: Integer, results: T::Hash[String, T::Boolean],
               results_file: Pathname, details: T::Hash[String, String], details_file: Pathname)
          .returns(T::Hash[String, TokenResult])
      }
      def audit_batch(tokens:, jobs:, results:, results_file:, details:, details_file:)
        fetch_queue = T.let(Queue.new, Queue)
        tokens.each { |token| fetch_queue << token }
        audit_queue = T.let(Queue.new, Queue)

        mutex = T.let(Mutex.new, Mutex)
        batch_results = T.let({}, T::Hash[String, TokenResult])

        worker_count = [jobs, tokens.length].min
        progress_indexes = tokens.each_with_index.to_h
        initialize_progress_display(tokens)

        fetch_workers = Array.new(worker_count) do
          Thread.new do
            Thread.current.report_on_exception = false

            loop do
              token = begin
                fetch_queue.pop(true)
              rescue ThreadError
                break
              end

              fetched = fetch_token(
                token,
                mutex,
                progress_index: progress_indexes.fetch(token),
                total_lines:    tokens.length,
              )
              if fetched.passed
                audit_queue << token
              else
                record_result(
                  token:         token,
                  result:        fetched,
                  mutex:         mutex,
                  results:       results,
                  batch_results: batch_results,
                  results_file:  results_file,
                  details:       details,
                  details_file:  details_file,
                )
              end
            end
          end
        end

        audit_workers = Array.new(worker_count) do
          Thread.new do
            Thread.current.report_on_exception = false

            loop do
              token = audit_queue.pop
              break if token.nil?

              result = audit_token(
                token,
                mutex,
                progress_index: progress_indexes.fetch(token),
                total_lines:    tokens.length,
              )
              record_result(
                token:         token,
                result:        result,
                mutex:         mutex,
                results:       results,
                batch_results: batch_results,
                results_file:  results_file,
                details:       details,
                details_file:  details_file,
              )
            end
          end
        end

        fetch_workers.each(&:join)
        worker_count.times { audit_queue << nil }
        audit_workers.each(&:join)
        finalize_progress_display
        batch_results
      end

      sig {
        params(token: String, mutex: Mutex, progress_index: Integer, total_lines: Integer).returns(TokenResult)
      }
      def fetch_token(token, mutex, progress_index:, total_lines:)
        log_progress(mutex, progress_index, total_lines, "fetching #{token}", color: :blue)
        fetch_stdout, fetch_stderr, fetch_status, timed_out = fetch_with_timeout(token)
        if timed_out
          log_progress(mutex, progress_index, total_lines, "fetch timeout #{token}", color: :yellow)
          return TokenResult.new(
            passed:         false,
            error:          "Fetch timed out after #{FETCH_TIMEOUT_SECONDS} seconds.",
            failure_source: "fetch_timeout",
            persist_result: false,
          )
        end

        unless fetch_status.success?
          error = extract_error(fetch_stdout, fetch_stderr)
          log_progress(mutex, progress_index, total_lines, "fetch failed #{token}", color: :orange)
          return TokenResult.new(
            passed:         false,
            error:          error,
            failure_source: "fetch",
            persist_result: true,
          )
        end

        TokenResult.new(passed: true, error: nil, failure_source: nil, persist_result: true)
      end

      sig {
        params(token: String, mutex: Mutex, progress_index: Integer, total_lines: Integer).returns(TokenResult)
      }
      def audit_token(token, mutex, progress_index:, total_lines:)
        log_progress(mutex, progress_index, total_lines, "auditing #{token}", color: :yellow)
        stdout, stderr, status = Open3.capture3(
          "brew", "audit", "--cask", "--online", "--only=signing", token
        )

        if status.success?
          log_progress(mutex, progress_index, total_lines, "passed #{token}", color: :green)
          return TokenResult.new(passed: true, error: nil, failure_source: nil, persist_result: true)
        end

        error = extract_error(stdout, stderr)
        log_progress(mutex, progress_index, total_lines, "audit failed #{token}", color: :red)
        TokenResult.new(passed: false, error: error, failure_source: "audit", persist_result: true)
      end

      sig { params(token: String).returns([String, String, Process::Status, T::Boolean]) }
      def fetch_with_timeout(token)
        stdout_output = T.let(+"", String)
        stderr_output = T.let(+"", String)
        timed_out = T.let(false, T::Boolean)
        status = T.let(nil, T.nilable(Process::Status))

        Open3.popen3("brew", "fetch", "--cask", "--retry", token) do |stdin, stdout, stderr, wait_thread|
          stdin.close
          stdout_reader = Thread.new { stdout.read }
          stderr_reader = Thread.new { stderr.read }

          begin
            Timeout.timeout(FETCH_TIMEOUT_SECONDS) do
              status = wait_thread.value
            end
          rescue Timeout::Error
            timed_out = true
            Process.kill("TERM", wait_thread.pid)
            begin
              Timeout.timeout(5) do
                status = wait_thread.value
              end
            rescue Timeout::Error
              Process.kill("KILL", wait_thread.pid)
              status = wait_thread.value
            rescue Errno::ESRCH
              status = wait_thread.value
            end
          ensure
            stdout_output = T.cast(stdout_reader.value, String)
            stderr_output = T.cast(stderr_reader.value, String)
          end
        end

        [stdout_output, stderr_output, T.must(status), timed_out]
      end

      sig {
        params(
          token:         String,
          result:        TokenResult,
          mutex:         Mutex,
          results:       T::Hash[String, T::Boolean],
          batch_results: T::Hash[String, TokenResult],
          results_file:  Pathname,
          details:       T::Hash[String, String],
          details_file:  Pathname,
        ).void
      }
      def record_result(token:, result:, mutex:, results:, batch_results:, results_file:, details:, details_file:)
        mutex.synchronize do
          batch_results[token] = result
          return unless result.persist_result

          results[token] = result.passed
          if result.error.present?
            details[token] = T.must(result.error)
          else
            details.delete(token)
          end
          save_results(results_file, results)
          save_details(details_file, details)
        end
      end

      sig { params(tokens: T::Array[String]).void }
      def initialize_progress_display(tokens)
        return unless $stdout.tty?

        tokens.each { |token| puts "queued #{token}" }
      end

      sig { void }
      def finalize_progress_display
        return unless $stdout.tty?

        puts
      end

      sig {
        params(tokens: T::Array[String], audit_results: T::Hash[String, TokenResult],
               details: T::Hash[String, String]).void
      }
      def report_failures(tokens:, audit_results:, details:)
        failed_tokens = tokens.select { |token| audit_results.fetch(token).passed == false }
        return if failed_tokens.empty?

        puts if $stdout.tty?

        failed_tokens.each do |token|
          puts "==> #{token}"
          detail = details[token].presence || audit_results.fetch(token).error || "Command failed without output."
          detail.each_line do |line|
            puts line.chomp
          end
          puts
        end
      end

      sig { params(tokens: T::Array[String], audit_results: T::Hash[String, TokenResult]).void }
      def deprecate_audit_failures(tokens:, audit_results:)
        tokens.each do |token|
          result = audit_results.fetch(token)
          next if result.passed
          next if result.failure_source != "audit"

          ohai "Running brew deprecate-gatekeeper-cask #{token}"
          stdout, stderr, status = Open3.capture3("brew", "deprecate-gatekeeper-cask", token)
          next if status.success?

          output = [stdout, stderr].compact_blank.join("\n").strip
          opoo(output.presence || "brew deprecate-gatekeeper-cask #{token} failed.")
        end
      end

      sig {
        params(mutex: Mutex, progress_index: Integer, total_lines: Integer, message: String, color: Symbol).void
      }
      def log_progress(mutex, progress_index, total_lines, message, color:)
        mutex.synchronize do
          if $stdout.tty?
            reposition_cursor(progress_index, total_lines) do
              print(colorize(message, color))
            end
          else
            puts message
          end
        end
      end

      sig { params(stdout: String, stderr: String).returns(String) }
      def extract_error(stdout, stderr)
        output = [stderr, stdout].reject(&:empty?).join("\n").strip
        return "Command failed without output." if output.empty?

        output
      end

      sig { params(message: String, color: Symbol).returns(String) }
      def colorize(message, color)
        ansi = case color
        when :green
          ANSI_GREEN
        when :red
          ANSI_RED
        when :yellow
          ANSI_YELLOW
        when :blue
          ANSI_BLUE
        when :orange
          ANSI_ORANGE
        else
          ""
        end

        return message if ansi.empty?

        "#{ansi}#{message}#{ANSI_RESET}"
      end

      sig { params(progress_index: Integer, total_lines: Integer, _blk: T.proc.void).void }
      def reposition_cursor(progress_index, total_lines, &_blk)
        up_lines = total_lines - progress_index
        print "\e[#{up_lines}A" if up_lines.positive?
        print "\r\e[2K"
        yield
        print "\e[#{up_lines}B" if up_lines.positive?
        $stdout.flush
      end

      sig { void }
      def report_downloads_cache_size
        downloads_dir = HOMEBREW_CACHE/"downloads"
        return unless downloads_dir.directory?

        total_size = Dir.glob("#{downloads_dir}/**/*", File::FNM_DOTMATCH)
                        .sum { |path| File.file?(path) ? File.size(path) : 0 }

        message = "Homebrew downloads cache is #{format_gigabytes(total_size)} GB in #{downloads_dir}."
        if total_size > DOWNLOADS_WARNING_THRESHOLD_BYTES
          opoo message
        else
          ohai message
        end
      end

      sig { params(bytes: Integer).returns(String) }
      def format_gigabytes(bytes)
        format("%.1f", bytes.to_f / 1024 / 1024 / 1024)
      end
    end
  end
end
