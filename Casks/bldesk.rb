cask "bldesk" do
  version "1.0.62-beta.27"
  sha256 "42d59df4e0c3578eb428bb103c881cc2f64a5caa80c17ca59a4cfd4719c2fdc4"

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
