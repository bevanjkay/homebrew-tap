cask "shadps4" do
  version "2026-09-11,05f02f9ab4e554ed526585cbc1728f841673fd6e"
  sha256 "64fb3225e0fb3ba265423a89b506b2cbd531494db38f77b2a2721c98f8c0c289"

  url "https://github.com/shadps4-emu/shadps4-qtlauncher/releases/download/shadPS4QtLauncher-#{version.tr(",", "-")}/shadPS4QtLauncher-macos-qt-#{version.csv.first}-#{version.csv.second&.slice(0, 7)}.zip"
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

  depends_on macos: :tahoe

  app "shadPS4QtLauncher.app"

  uninstall quit: "com.shadps4-emu.shadps4-qtlauncher"

  zap trash: [
    "~/Library/Application Support/shadPS4",
    "~/Library/Preferences/com.shadps4-emu.shadps4.plist",
  ]
end
