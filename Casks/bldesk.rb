cask "bldesk" do
  version "1.0.47"
  sha256 "9f48d8ade9aa538e7d5c23317f68c1e6cf02feff300a1dbef00e02ea7615cd88"

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
