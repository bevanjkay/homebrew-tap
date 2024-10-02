# typed: true
# frozen_string_literal: true

require "abstract_command"
require "open3"
require "digest"

module Homebrew
  module Cmd
    class GuiInstall < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `brew gui-install` <token>

          Installs or reinstalls an `installer manual` cask.
        EOS

        named_args :token, min: 1, max: 1
      end

      def run
        token = args.named.first
        cask = Cask::CaskLoader.load(token)

        # Find the manual installer artifact
        manual_installer = cask.artifacts.select { |artifact| artifact.is_a?(Cask::Artifact::Installer) }&.first
        installer_path = File.join(cask.caskroom_path, cask.version.to_s, manual_installer.path)

        system "brew", "reinstall", token

        system "open '#{installer_path}' -W"
      end
    end
  end
end
