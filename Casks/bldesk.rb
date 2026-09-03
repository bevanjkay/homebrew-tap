cask "bldesk" do
  version "1.0.45"
  sha256 "3e1e5b6bcd98977c112d3b918f2756846aeb4e7bf6cedaa3a753ba0d838ddbf3"

  url "https://github.com/termau/bldesk/releases/download/v#{version}/BLDesk-#{version}-mac-universal.dmg"
  name "BLDesk"
  desc "Desktop client for BinaryLane Cloud"
  homepage "https://github.com/termau/bldesk/"

  auto_updates true
  depends_on macos: :big_sur

  app "BLDesk.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/BLDesk.app"
  end

  zap trash: [
    "~/Library/Application Support/bldesk",
    "~/Library/Application Support/Caches/bldesk-updater",
    "~/Library/Preferences/com.termau.bldesk.plist",
    "~/Library/Saved Application State/com.termau.bldesk.savedState",
  ]
end
