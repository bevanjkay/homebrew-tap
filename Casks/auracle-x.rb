cask "auracle-x" do
  version "2.2.0"
  sha256 "59da20f711b7f240d6e82ce487bee80222f97e310302f7bf5209e409ac742f57"

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

  caveats do
    requires_rosetta
  end
end
