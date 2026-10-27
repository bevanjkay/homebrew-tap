cask "bldesk" do
  version "1.0.62-beta.37"
  sha256 "68e652e360e16dbf63c5c43aeadbc6824ed0e594e8d8c1e818899df2d6d719c5"

  url "https://github.com/termau/bldesk/releases/download/v#{version}/BLDesk-#{version}-mac-universal.dmg"
  name "BLDesk"
  desc "Desktop client for BinaryLane Cloud"
  homepage "https://github.com/termau/bldesk/"

  livecheck do
    url :url
    regex(/v(.+)/i)
  end

  auto_updates true
  depends_on macos: :ventura

  app "BLDesk.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/BLDesk.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/bldesk",
    "~/Library/Application Support/Caches/bldesk-updater",
    "~/Library/Preferences/com.termau.bldesk.plist",
    "~/Library/Saved Application State/com.termau.bldesk.savedState",
  ]
end
