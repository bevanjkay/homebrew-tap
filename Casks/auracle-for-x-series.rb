cask "auracle-for-x-series" do
  version "2.0.0"
  sha256 "d90f265673f238eff5cde5af2b0295d5addf68858fba12e257f761ef1d5d4964"

  url "https://cdn.iconnectivity.com/software/AuracleForX#{version}.dmg"
  name "Auracle for X-Series"
  desc "Control iConnectivity Audio Devices"
  homepage "https://www.iconnectivity.com/auracle-x-series"

  livecheck do
    url "https://d3tu8f3g4q5sdm.cloudfront.net/appcast.xml"
    strategy :sparkle
  end

  auto_updates true

  app "Auracle for X-Series.app"

  zap trash: [
    "~/Library/Application Support/Auracle for X-Series",
    "~/Library/HTTPStorages/com.iconnectivity.auracle",
    "~/Library/Logs/Auracle for X-Series_debug.log",
    "~/Library/Preferences/com.iconnectivity.auracle.plist",
    "~/Library/Saved Application State/com.iconnectivity.auracle.savedState",
  ]
end
