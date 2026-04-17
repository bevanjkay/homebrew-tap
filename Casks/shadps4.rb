cask "shadps4" do
  version "2026-04-17,df91fb347c2bef78fd89008c204e52320a9ecc1c"
  sha256 "c0bc08a42f50fcafb0f5e7330fcc4327cb5bc357f1281297886e579b047b0d22"

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
