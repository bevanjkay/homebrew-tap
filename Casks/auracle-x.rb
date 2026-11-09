cask "auracle-x" do
  version "2.6.0"
  sha256 "beb3dd3084c82a63c1440c513e61ef8d4d9efe98fb926a03da9f09934e400c22"

  url "https://cdn.iconnectivity.com/software/AuracleX#{version}.dmg"
  name "Auracle for X-Series"
  desc "Control iConnectivity Audio Devices"
  homepage "https://www.iconnectivity.com/auracle-x-series"

  livecheck do
    url "https://cdn.iconnectivity.com/maccast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :monterey

  app "Auracle X.app"

  uninstall quit: "com.iconnectivity.auracle"

  zap trash: [
    "~/Library/Application Support/Auracle for X-Series",
    "~/Library/Application Support/Auracle X",
    "~/Library/Caches/Auracle X",
    "~/Library/HTTPStorages/com.iconnectivity.auracle",
    "~/Library/Logs/Auracle for X-Series_debug.log",
    "~/Library/Logs/Auracle X_debug.log",
    "~/Library/Preferences/com.iconnectivity.auracle.plist",
    "~/Library/Saved Application State/com.iconnectivity.auracle.savedState",
  ]
end
