cask "bldesk" do
  version "1.0.63-beta.7"
  sha256 "f37c9cb7ac266be1d4434224ca081c6bb8a3290702d3478cdf41c0279dbe3c9d"

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
