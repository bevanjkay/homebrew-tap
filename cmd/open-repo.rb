# typed: true
# frozen_string_literal: true

require "abstract_command"
require "formula"
require "open3"

module Homebrew
  module Cmd
    class OpenRepo < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `open-repo` <formula>

          Opens the GitHub repository of a formula.
        EOS

        named_args :formula, min: 1, max: 1
      end

      def run
        formula_name = args.named.first
        formula = Formula[formula_name]

        homepage = formula.homepage
        github_repo = if homepage.include?("github.com")
          homepage
        else
          infer_github_repo(formula.stable.url)
        end

        if github_repo
          ohai "Opening GitHub repository for #{formula_name}: #{github_repo}"
          system "open", github_repo
        else
          onoe "Could not infer GitHub repository for #{formula_name}"
        end
      end

      private

      def infer_github_repo(url)
        match = url.match(%r{https?://github.com/([^/]+)/([^/]+)})
        return unless match

        "https://github.com/#{match[1]}/#{match[2]}"
      end
    end
  end
end
