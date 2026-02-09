cask "shadps4" do
  version "2026-02-09,9d93c5728c5659e678ee10385282b947912535a6"
  sha256 "dd8685b22a7b2426f803d7030610fa6f909412ae0963bc58b96b5d26e2ec7f39"

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
