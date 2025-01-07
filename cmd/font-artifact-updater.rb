# typed: strict
# frozen_string_literal: true

require "abstract_command"
require "open3"
require "digest"
require "cask/download"

module Homebrew
  module Cmd
    class FontArtifactUpdater < AbstractCommand
      cmd_args do
        usage_banner <<~EOS
          `font-artifact-updater` <token>

          Updates the font artifacts for a given font cask.
          Adds all fonts from the binary package, so may require manual filtering.
        EOS

        named_args :token, min: 1, max: 1
      end

      FONT_EXT_PATTERN = T.let(/.(otf|ttf)\Z/i, Regexp)

      FONT_WEIGHTS = T.let([
        /black/i,
        /bold/i,
        /book/i,
        /hairline/i,
        /heavy/i,
        /light/i,
        /medium/i,
        /normal/i,
        /regular/i,
        /roman/i,
        /thin/i,
        /ultra/i,
      ].freeze, T::Array[Regexp])

      FONT_STYLES = T.let([
        /italic/i,
        /oblique/i,
        /roman/i,
        /slanted/i,
        /upright/i,
      ].freeze, T::Array[Regexp])

      FONT_WIDTHS = T.let([
        /compressed/i,
        /condensed/i,
        /extended/i,
        /narrow/i,
        /wide/i,
      ].freeze, T::Array[Regexp])

      sig { params(enum: T::Array[String]).returns(T.nilable(String)) }
      def mce(enum)
        enum.group_by(&:itself).values.max_by(&:size)&.first
      end

      sig { params(cmd: String, blob: String).returns(String) }
      def eval_bin_cmd(cmd, blob)
        IO.popen(cmd, "r+b") do |io|
          io.print(blob)
          io.close_write
          io.read
        end
      end

      # Determine archive type and return the appropriate command for listing files
      sig { params(archive: Pathname).returns(String) }
      def list_cmd(archive)
        case File.extname(archive).downcase
        when ".zip"
          "zipinfo -1 #{archive}"
        when ".7z"
          "sh -c '7z l -ba #{archive} | grep -o \"[^ ]*$\"'"
        when ".gz"
          raise "Unsupported .gz archive type" unless File.basename(archive, ".gz").end_with?(".tar")

          "tar -tzf #{archive}"

        else
          raise "Unsupported archive type"
        end
      end

      sig { params(archive: Pathname).returns(T::Array[String]) }
      def font_paths(archive)
        cmd = list_cmd(archive)

        all_fonts = IO.popen(cmd, "r") do |io|
          io.read.chomp.split("\n")
            .grep(FONT_EXT_PATTERN)                        # Filter by font file extensions
            .reject { |x| x.start_with?("__MACOSX") }      # Reject files in __MACOSX directory
            .grep_v(%r{(?:\A|/)\._})                       # Reject metadata files
            .sort                                          # Sort the list of files
        end

        # Hash to store basenames and preferred font paths
        preferred_fonts = {}

        all_fonts.each do |font|
          basename = File.basename(font, ".*")
          ext = File.extname(font).downcase

          # Keep the .otf version if it exists, otherwise, keep any version
          preferred_fonts[basename] = font if preferred_fonts[basename].nil? || ext == ".otf"
        end

        # Return only the preferred font paths
        preferred_fonts.values
      end

      sig { params(cask: Cask::Cask, fonts: T::Array[String]).returns(String) }
      def update_cask_content(cask, fonts)
        content = cask.source.split("\n")
        font_content = fonts.map do |font|
          "  font \"#{font}\"".gsub(cask.version.to_s, "\#{version}")
        end
        new_content = []
        last_match = T.let(nil, T.nilable(Integer))
        content.each_with_index do |line, index|
          if line.match?(/^  font /)
            last_match = index
            next
          end
          new_content << font_content if last_match && last_match == index -1
          new_content << line
        end
        new_content << ""
        new_content.join("\n")
      end

      sig { override.void }
      def run
        token = args.named.first

        cask = Cask::CaskLoader.load(token)
        path = Cask::Download.new(cask).fetch

        ohai "Finding font paths" if args.debug?
        fonts = font_paths(path)

        cask.token.split("-").first[0]

        if args.debug?
          ohai "Found fonts in archive:"
          puts fonts.join("\n")
        end

        new_content = update_cask_content(cask, fonts)

        File.write(cask.sourcefile_path, new_content)

        ohai "Running brew style --fix #{token}" if args.debug?
        system("brew", "style", "--fix", T.must(token))
      end
    end
  end
end
