cask "shadps4" do
  version "2026-04-27,76246a327b8805d355738157ea444e4d9a799ea3"
  sha256 "8de5844c3db9b758da5627d44727942bb91f11aed82fafcc6d103f2603ef60df"

  url "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-#{version.tr(",", "-")}/shadPS4QtLauncher-macos-qt-#{version.csv.first}-#{version.csv.second&.slice(0, 7)}.zip",
      verified: "github.com/shadps4-emu/shadps4-qtlauncher/"
  name "shadps4"
  desc "PlayStation 4 emulator"
  homepage "https://shadps4.net/"

  livecheck do
    url :url
    regex(/v?shadps4QTLauncher[._-](.+)/i)
    strategy :git do |tags, regex|
      tags.filter_map do |tag|
        match = tag[regex, 1]
        split = match&.split("-")
        next if split.blank?

        part_one = split[..2]&.join("-")
        part_two = split[3]

        "#{part_one},#{part_two}"
      end
    end
  end

  depends_on macos: ">= :sequoia"

  app "shadPS4QtLauncher.app"

  zap trash: [
    "~/Library/Application Support/shadPS4",
    "~/Library/Preferences/com.shadps4-emu.shadps4.plist",
  ]
end
