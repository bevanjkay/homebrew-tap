cask "shadps4" do
  version "2026-02-28,7177dc29879fa91b8743174a9f8a1d1ff44ce0c0"
  sha256 "4adcdc7959c6aa9d42508c2890b4546f331ed4d4f10f5a9527e27f9c0326c9db"

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
