cask "bldesk" do
  version "1.0.62-beta.34"
  sha256 "8f9b5a9e8630d4292bf4be90eb7b17b944b1be748a19380517b36e15e7d8a446"

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
