# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "open3"
require "date"

module Homebrew
  module Cmd
    class DisableDeprecatedPackages < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `disable-deprecated-packages` <tap> [--dry-run]

          Disables deprecated packages in the specified tap.
          Use `--dry-run` to skip git commands and print the list of packages
          that would be disabled.
        EOS

        switch "--dry-run", description: "Skip git commands and print the list of packages to be disabled."
        named_args :tap, min: 1, max: 1
      end

      sig { override.void }
      def run
        ENV["HOMEBREW_EVAL_ALL"] = "1"
        tap_string = args.named.first
        @target_tap = T.let(Tap.fetch(T.must(tap_string)), T.nilable(Tap))

        odie "Invalid tap: #{tap_string}" if @target_tap.nil?

        dry_run = args.flags_only.include?("--dry-run")

        package_files = tap_package_files
        packages_to_disable = find_deprecated(package_files: package_files)

        if dry_run
          puts "Dry run mode: The following packages would be disabled:"
          packages_to_disable.each { |file_path| puts "- #{package_name(file_path)}" }
          return
        end

        if packages_to_disable.any?
          branch_name = "disable-packages-#{Date.today.strftime("%Y-%m-%d")}"
          git "-C", @target_tap.path.to_s, "checkout", "-b", branch_name
        end

        puts "Disabling deprecated packages..."

        packages_to_disable.each do |file_path|
          content = File.read(file_path)
          new_content = content.gsub(
            /(deprecate! date: ".*?"(, because: .*?)?)$/,
            "\\1\n  disable! date: \"#{Date.today}\"\\2",
          ).gsub(/^\s*livecheck\s+do\s*\n(?:\s*.*\n)*?\s*end\n?/, "")
          File.write(file_path, new_content)
        end

        tap_dir = @target_tap.path

        out, err, status = Open3.capture3 "git", "-C", tap_dir.to_s, "status", "--porcelain",
                                          "--ignore-submodules=dirty"
        raise err unless status.success?

        if out.chomp.empty?
          puts "No packages disabled."
          exit
        end

        git "-C", tap_dir.to_s, "add", "--all"

        packages_to_disable.each do |file_path|
          name = package_name(file_path)
          puts "Disabled `#{name}`."
          git "-C", tap_dir.to_s, "commit", file_path, "--message",
              "#{name}: disable", "--quiet"
        end
      end

      sig { params(args: ::String).void }
      def git(*args)
        system "git", *args
        exit $CHILD_STATUS.exitstatus unless $CHILD_STATUS.success?
      end

      sig { returns(T::Array[String]) }
      def tap_package_files
        files = T.let([], T::Array[String])

        formula_dir = T.must(@target_tap).path/"Formula"
        cask_dir = T.must(@target_tap).path/"Casks"

        files.concat(Dir.glob((formula_dir/"**/*.rb").to_s)) if formula_dir.directory?
        files.concat(Dir.glob((cask_dir/"**/*.rb").to_s)) if cask_dir.directory?

        files
      end

      sig { params(package_files: T::Array[String]).returns(T::Array[String]) }
      def find_deprecated(package_files:)
        puts "Finding deprecated packages..."
        twelve_months_ago = Date.today << 12 # Subtracts 12 months from the current date

        package_files.select do |file_path|
          content = File.read(file_path)
          name = package_name(file_path)

          next false if name == "terraform"
          next false if content.match?(/^\s*disable!\s+date:\s*"/)

          deprecate_match = content.match(/^\s*deprecate!\s+date:\s*"(\d{4}-\d{2}-\d{2})"/)
          next false if deprecate_match.nil?

          deprecation_date = begin
            Date.parse(T.must(deprecate_match[1]))
          rescue Date::Error
            nil
          end
          next false if deprecation_date.nil?

          deprecation_date <= twelve_months_ago
        end
      end

      sig { params(file_path: String).returns(String) }
      def package_name(file_path)
        File.basename(file_path, ".rb")
      end
    end
  end
end
