cask "shadps4" do
  version "0.10.0"
  sha256 "844a1504bc8157343650af14b2fcc488a8ce2aacfcf0bbd664cd462fd3daba4b"

  url "https://github.com/shadps4-emu/shadPS4/releases/download/v.#{version}/shadps4-macos-qt-#{version}.zip",
      verified: "github.com/shadps4-emu/shadPS4/"
  name "shadps4"
  desc "PlayStation 4 emulator"
  homepage "https://shadps4.net/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "shadps4.app"

  zap trash: [
    "~/Library/Application Support/shadPS4",
    "~/Library/Preferences/com.shadps4-emu.shadps4.plist",
  ]

  caveats do
    requires_rosetta
  end
end
