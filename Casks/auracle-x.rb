cask "auracle-x" do
  version "2.1.1"
  sha256 "64a62c6a083ef7226d8b5a1bb1725d1a96c1ffdea83105c03de183592bf0894b"

  url "https://cdn.iconnectivity.com/software/AuracleX#{version}.dmg"
  name "Auracle for X-Series"
  desc "Control iConnectivity Audio Devices"
  homepage "https://www.iconnectivity.com/auracle-x-series"

  livecheck do
    url "https://cdn.iconnectivity.com/maccast.xml"
    strategy :sparkle
  end

  auto_updates true

  app "Auracle X.app"

  zap trash: [
    "~/Library/Application Support/Auracle for X-Series",
    "~/Library/Application Support/Auracle X",
    "~/Library/HTTPStorages/com.iconnectivity.auracle",
    "~/Library/Logs/Auracle for X-Series_debug.log",
    "~/Library/Logs/Auracle X_debug.log",
    "~/Library/Preferences/com.iconnectivity.auracle.plist",
    "~/Library/Saved Application State/com.iconnectivity.auracle.savedState",
  ]
end
