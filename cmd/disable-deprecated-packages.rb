# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "formula"
require "cask/cask"
require "open3"
require "date"

module Homebrew
  module Cmd
    class DisableDeprecatedPackages < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `disable-deprecated-packages` <tap>

          Disables deprecated packages in the specified tap.
        EOS

        named_args :tap, min: 1, max: 1
      end

      sig { override.void }
      def run
        ENV["HOMEBREW_EVAL_ALL"] = "1"
        tap_string = args.named.first
        @target_tap = T.let(Tap.fetch(T.must(tap_string)), T.nilable(Tap))

        odie "Invalid tap: #{tap_string}" if @target_tap.nil?

        packages_to_disable = find_deprecated(packages: Formula.all + Cask::Cask.all)

        if packages_to_disable.any?
          branch_name = "disable-packages-#{Date.today.strftime("%Y-%m-%d")}"
          git "-C", @target_tap.path.to_s, "checkout", "-b", branch_name
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

      sig { params(args: ::String).void }
      def git(*args)
        system "git", *args
        exit $CHILD_STATUS.exitstatus unless $CHILD_STATUS.success?
      end

      sig { params(packages: T::Array[T.any(Formula, Cask::Cask)]).returns(T::Array[T.any(Formula, Cask::Cask)]) }
      def find_deprecated(packages: [])
        puts "Finding deprecated packages..."
        twelve_months_ago = Date.today << 12 # Subtracts 12 months from the current date

        packages.select do |package|
          next false if package.tap != @target_tap
          next false unless package.deprecated?
          next false if package.disable_date
          next false if package.deprecation_date.nil?

          package.deprecation_date <= twelve_months_ago
        end
      end

      sig { params(package: T.any(Formula, Cask::Cask)).returns(String) }
      def sourcefile_path(package)
        return package.path.to_s unless package.is_a?(Cask::Cask)

        package.sourcefile_path.to_s if package.is_a?(Cask::Cask)
      end
    end
  end
end
