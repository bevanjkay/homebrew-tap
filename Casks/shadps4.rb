cask "shadps4" do
  version "2026-03-03,9bccf1efc73f336cb7880d91377d467ff2219831"
  sha256 "2af79a477f44a92375953c19006158bf19f3bdc82a77285abf7a908ad4549998"

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
