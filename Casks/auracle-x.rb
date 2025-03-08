cask "auracle-x" do
  arch arm: "arm64", intel: "x86_64"

  version "2.3.1"
  sha256 arm:   "e4b52fa867b5536bf404d45afbcfaa865fbf7519432ce80f5203e90ad1e1dc1a",
         intel: "a14a074884c14c70bf582baa30f10842a67276bce5d7cde78aa2c12e586d973a"

  url "https://cdn.iconnectivity.com/software/AuracleX#{version}-#{arch}.dmg"
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
