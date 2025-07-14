# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "formula"
require "cask/cask"
require "open3"
require "date"

module Homebrew
  module Cmd
    class LsNoAutobump < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `ls-no-autobump` <tap> [--dry-run]

          List packages in the specified tap that are set to no autobump.
        EOS

        named_args :tap, min: 1, max: 1
      end

      sig { override.void }
      def run
        ENV["HOMEBREW_EVAL_ALL"] = "1"
        tap_string = args.named.first
        @target_tap = T.let(Tap.fetch(T.must(tap_string)), T.nilable(Tap))

        odie "Invalid tap: #{tap_string}" if @target_tap.nil?

        all_casks = Cask::Cask.all
        tap_casks = all_casks.select { |cask| cask.tap == @target_tap }
        pp tap_casks[0]
        no_autobump_casks = tap_casks.select do |cask|
          cask.autobump? == false && !cask.disabled? && !cask.version.latest?
        end

        all_formulae = Formula.all
        tap_formulae = all_formulae.select { |formula| formula.tap == @target_tap }
        no_autobump_formulae = tap_formulae.select do |formula|
          formula.autobump? == false && !formula.disabled?
        end

        puts no_autobump_casks.map(&:token) unless no_autobump_casks.nil?
        puts no_autobump_formulae.map(&:name) unless no_autobump_formulae.nil?
      end
    end
  end
end
