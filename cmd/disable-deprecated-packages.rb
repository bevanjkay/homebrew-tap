# typed: strict
# frozen_string_literal: true

require "date"
module Homebrew
  module Cmd
    class DisableDeprecatedPackages < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `disable-deprecated-packages` <tap>

          Disables packages deprecated for more than 12 months.
        EOS

        named_args :tap, min: 1, max: 1
      end

      def run
        ENV["HOMEBREW_EVAL_ALL"] = "1"
        tap_string = args.named.first
        @target_tap = Tap.fetch(tap_string)

        packages_to_disable = find_deprecated(packages: Formula.all + Cask::Cask.all)

        if packages_to_disable.any?
          branch_name = "disable-packages-#{Date.today.strftime("%Y-%m-%d")}"
          git "-C", @target_tap.path.to_s, "checkout", "-b", branch_name unless @dry_run
        end

        puts "Disabling deprecated packages..."

        packages_to_disable.each do |package|
          file_path = sourcefile_path(package)
          content = File.read(file_path)
          new_content = content
                        # Transform the `deprecate!` line
                        .gsub(/(deprecate! date: ".*?"(, because: .*?)?)$/,
                              "\\1\n  disable! date: \"#{Date.today}\"\\2")
                        # Remove the `livecheck` block, including nested content
                        .gsub(/^\s*livecheck\s+do\s*\n(?:\s*.*\n)*?\s*end\n?/, "")
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

        packages_to_disable.each do |package|
          name = package.is_a?(Formula) ? package.name : package.token
          puts "Disabled `#{name}`."
          git "-C", tap_dir.to_s, "commit", sourcefile_path(package), "--message",
              "#{name}: disable", "--quiet"
        end
      end

      def git(*args)
        system "git", *args
        exit $CHILD_STATUS.exitstatus unless $CHILD_STATUS.success?
      end

      def find_deprecated(packages: [])
        puts "Finding deprecated packages..."
        twelve_months_ago = Date.today << 12 # Subtracts 12 months from the current date

        packages.select do |package|
          next false if package.tap != @target_tap
          next false unless package.deprecated?
          next false if package.deprecation_date.nil?

          package.deprecation_date < twelve_months_ago
        end
      end

      def sourcefile_path(package)
        package.is_a?(Formula) ? package.path : package.sourcefile_path
      end
    end
  end
end
