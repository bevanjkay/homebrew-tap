cask "bldesk" do
  version "1.0.53"
  sha256 "db8e989571a345ac06d17782f9735fe594ac10d538c73240603ebc8e77a48605"

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
