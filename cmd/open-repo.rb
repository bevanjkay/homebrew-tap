# typed: strict
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

        named_args :formula, min: 1
      end

      sig { override.void }
      def run
        formulae = args.named.to_formulae

        homepages = formulae.filter_map do |formula|
          formula.homepage
          if formula.homepage.include?("github.com")
            formula.homepage
          else
            stable_url = infer_github_repo(T.must(T.must(formula.stable).url))
            head_url = infer_github_repo(T.must(T.must(formula.head).url)) if formula.head

            stable_url || head_url
          end
        end

        odie "No GitHub repository found for the given formulae." if homepages.empty?

        exec_browser(*homepages)
      end

      private

      sig { params(url: String).returns(T.nilable(String)) }
      def infer_github_repo(url)
        match = url.match(%r{https?://github.com/([^/]+)/([^/]+)})
        return unless match

        "https://github.com/#{match[1]}/#{match[2]}"
      end
    end
  end
end
