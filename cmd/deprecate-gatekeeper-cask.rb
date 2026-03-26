# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "cask/cask_loader"
require "open3"
require "tap"
require "tempfile"

module Homebrew
  module Cmd
    class DeprecateGatekeeperCask < AbstractCommand
      TARGET_TAP = T.let("homebrew/cask", String)
      TARGET_REPOSITORY = T.let("homebrew/homebrew-cask", String)
      DEFAULT_BRANCH = T.let("main", String)
      ORIGIN_REMOTE = T.let("origin", String)
      TARGET_DISABLE_STANZA = T.let(
        '  disable! date: "2026-09-01", because: :fails_gatekeeper_check',
        String,
      )
      PR_NOTE = T.let(
        "Deprecating because the cask fails the macOS gatekeeper check",
        String,
      )

      cmd_args do
        usage_banner <<~EOS
          `deprecate-gatekeeper-cask` <cask>

          Add a Gatekeeper disable stanza to a `homebrew/cask` cask, validate it,
          commit it on a new branch, and open a pull request in `homebrew-cask`.
        EOS

        named_args :cask, min: 1, max: 1
      end

      sig { override.void }
      def run
        ENV["HOMEBREW_EVAL_ALL"] = "1"

        cask = args.named.to_casks.fetch(0)
        target_tap = Tap.fetch(TARGET_TAP)

        odie "This command only supports #{TARGET_TAP} casks." if cask.tap != target_tap

        repo = target_tap.path
        branch_name = "#{cask.token}-deprecate"
        branch_created = T.let(false, T::Boolean)
        branch_pushed = T.let(false, T::Boolean)

        begin
          ensure_clean_repo(repo)
          ensure_branch_available(repo, branch_name)
          ensure_no_disable_stanza(cask.sourcefile_path)
          git!(repo, "checkout", "-b", branch_name, "#{ORIGIN_REMOTE}/#{DEFAULT_BRANCH}")
          branch_created = true

          old_contents = cask.sourcefile_path.read
          new_contents = updated_contents(old_contents)
          odie "#{cask.token} already contains #{TARGET_DISABLE_STANZA.inspect}." if new_contents == old_contents

          cask.sourcefile_path.atomic_write(new_contents)

          ohai "Running brew style --fix #{cask.token}"
          brew!("style", "--fix", cask.token)

          ohai "Running brew audit --cask --online --only=signing #{cask.token}"
          brew!("audit", "--cask", "--online", "--only=signing", cask.token)

          git!(repo, "add", cask.sourcefile_path.to_s)
          git!(repo, "commit", "-m", "#{cask.token}: deprecate")
          git!(repo, "push", "--set-upstream", ORIGIN_REMOTE, branch_name)
          branch_pushed = true

          pr_url = create_pr(repo, branch_name, cask.token)
          git!(repo, "checkout", DEFAULT_BRANCH)

          puts pr_url
        rescue StandardError, SystemExit
          cleanup_failed_run(repo, branch_name, branch_created:, branch_pushed:)
          raise
        end
      end

      private

      sig { params(repo: Pathname).void }
      def ensure_clean_repo(repo)
        stdout = git_output!(repo, "status", "--porcelain")
        odie "#{repo} has uncommitted changes." if stdout.present?
      end

      sig { params(repo: Pathname, branch_name: String).void }
      def ensure_branch_available(repo, branch_name)
        local_branch_exists = system(
          "git", "-C", repo.to_s, "show-ref", "--verify", "--quiet", "refs/heads/#{branch_name}"
        )
        odie "Local branch already exists: #{branch_name}" if local_branch_exists

        remote_branch_exists = system(
          "git", "-C", repo.to_s, "show-ref", "--verify", "--quiet", "refs/remotes/#{ORIGIN_REMOTE}/#{branch_name}"
        )
        odie "Remote branch already exists: #{ORIGIN_REMOTE}/#{branch_name}" if remote_branch_exists
      end

      sig { params(cask_file: Pathname).void }
      def ensure_no_disable_stanza(cask_file)
        contents = cask_file.read
        return unless contents.match?(/^\s*disable!\s+date:\s*"/)

        odie "#{cask_file.basename(".rb")} already has a disable stanza."
      end

      sig { params(contents: String).returns(String) }
      def updated_contents(contents)
        updated = contents.sub(
          /^\s*(disable!|deprecate!)\s+date:\s*".*?"(?:,\s*because:\s*:[a-z_]+)?$/,
          TARGET_DISABLE_STANZA,
        )
        return updated if updated != contents

        updated = contents.sub(
          /(^\s*homepage\s+.*\n)(\n)?/,
          "\\1#{TARGET_DISABLE_STANZA}\n\n",
        )
        odie "Could not find a homepage stanza to insert #{TARGET_DISABLE_STANZA.inspect}." if updated == contents

        updated
      end

      sig { params(repo: Pathname, branch_name: String, token: String).returns(String) }
      def create_pr(repo, branch_name, token)
        body = pr_body(repo, token)

        Tempfile.create(["#{token}-deprecate", ".md"]) do |file|
          file.write(body)
          file.flush

          stdout = command_output!(
            "gh", "pr", "create",
            "--repo", TARGET_REPOSITORY,
            "--base", DEFAULT_BRANCH,
            "--head", branch_name,
            "--title", "#{token}: deprecate",
            "--body-file", file.path
          )

          pr_url = stdout.lines.map(&:strip).reject(&:empty?).last
          odie "Failed to determine PR URL." if pr_url.blank?

          pr_url
        end
      end

      sig { params(repo: Pathname, token: String).returns(String) }
      def pr_body(repo, token)
        template = (repo/".github/PULL_REQUEST_TEMPLATE.md").read
        "#{template.gsub("<cask>", token).rstrip}\n\n#{PR_NOTE}\n"
      end

      sig { params(repo: Pathname, args: String).void }
      def git!(repo, *args)
        command_output!("git", "-C", repo.to_s, *args)
      end

      sig { params(repo: Pathname, args: String).returns(String) }
      def git_output!(repo, *args)
        command_output!("git", "-C", repo.to_s, *args)
      end

      sig { params(args: String).void }
      def brew!(*args)
        command_output!(HOMEBREW_BREW_FILE.to_s, *args)
      end

      sig { params(repo: Pathname, branch_name: String, branch_created: T::Boolean, branch_pushed: T::Boolean).void }
      def cleanup_failed_run(repo, branch_name, branch_created:, branch_pushed:)
        return unless branch_created

        safe_command("git", "-C", repo.to_s, "reset", "--hard", "HEAD")
        safe_command("git", "-C", repo.to_s, "checkout", DEFAULT_BRANCH)
        safe_command("git", "-C", repo.to_s, "branch", "-D", branch_name)
        return unless branch_pushed

        safe_command("git", "-C", repo.to_s, "push", ORIGIN_REMOTE, "--delete", branch_name)
      end

      sig { params(args: String).returns(String) }
      def command_output!(*args)
        stdout, stderr, status = Open3.capture3(*args)
        return stdout if status.success?

        output = [stdout, stderr].compact_blank.join("\n").strip
        odie output.presence || "Command failed: #{args.join(" ")}"
      end

      sig { params(args: String).void }
      def safe_command(*args)
        _stdout, _stderr, _status = Open3.capture3(*args)
      end
    end
  end
end
