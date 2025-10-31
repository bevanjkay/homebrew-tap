cask "shadps4" do
  version "0.12.0"
  sha256 "2fa767266ee51449aa2c26f10e6ebd2dd2bc49aea4d63678de74e5b91c9ded15"

  url "https://github.com/shadps4-emu/shadPS4/releases/download/v.#{version}/shadps4-macos-qt-#{version}.zip",
      verified: "github.com/shadps4-emu/shadPS4/"
  name "shadps4"
  desc "PlayStation 4 emulator"
  homepage "https://shadps4.net/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "shadps4.app"

  zap trash: [
    "~/Library/Application Support/shadPS4",
    "~/Library/Preferences/com.shadps4-emu.shadps4.plist",
  ]

  caveats do
    requires_rosetta
  end
end
