# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "formula"
require "cask/cask"
require "open3"
require "date"

module Homebrew
  module Cmd
    class RemoveDisabledAutobump < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `remove-disabled-autobump` <tap>

          Removes disabled casks from autobump.
        EOS

        named_args :tap, min: 1, max: 1
      end

      sig { override.void }
      def run
        ENV["HOMEBREW_EVAL_ALL"] = "1"
        tap_string = args.named.first
        @target_tap = T.let(Tap.fetch(T.must(tap_string)), T.nilable(Tap))

        odie "Invalid tap: #{tap_string}" if @target_tap.nil?

        autobump_file = @target_tap.path/".github/autobump.txt"

        odie "Autobump file not found: #{autobump_file}" unless autobump_file.exist?

        all_packages = Formula.all + Cask::Cask.all

        odebug "Finding disabled packages..."
        disabled_packages = all_packages.select do |package|
          next false if package.tap != @target_tap
          next false unless package.disabled?

          true
        end

        # if no disabled packages found, exit
        odie "No disabled packages found." if disabled_packages.empty?
        odebug "Found #{disabled_packages.length} disabled packages."

        # if the autobump list contains any disabled packages, remove them
        autobump_list = File.readlines(autobump_file).map(&:chomp)
        updated_list = autobump_list - disabled_packages.map do |package|
          package.is_a?(Cask::Cask) ? package.token : package.name
        end

        if updated_list == autobump_list
          puts "Checks completed. No changes required."
          return
        end

        puts "Updating autobump file..."
        File.write(autobump_file, "#{updated_list.join("\n")}\n")

        tap_dir = @target_tap.path
        branch_name = "autobump-remove-disabled-#{Date.today.strftime("%Y-%m-%d")}"
        git "-C", tap_dir.to_s, "checkout", "-b", branch_name

        _, err, status = Open3.capture3 "git", "-C", tap_dir.to_s, "status", "--porcelain",
                                        "--ignore-submodules=dirty"
        raise err unless status.success?

        git "-C", tap_dir.to_s, "add", "--all"

        git "-C", tap_dir.to_s, "commit", autobump_file, "--message", "autobump: remove disabled packages"
      end

      sig { params(args: ::T.any(String, Pathname)).void }
      def git(*args)
        system "git", *args
        exit $CHILD_STATUS.exitstatus unless $CHILD_STATUS.success?
      end

      sig { params(package: T.any(Formula, Cask::Cask)).returns(String) }
      def sourcefile_path(package)
        package.path.to_s unless package.is_a?(Cask::Cask)
        package.sourcefile_path.to_s if package.is_a?(Cask::Cask)
      end
    end
  end
end
