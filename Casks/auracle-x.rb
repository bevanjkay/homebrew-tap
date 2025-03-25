cask "auracle-x" do
  arch arm: "arm64", intel: "x86_64"

  version "2.3.2"
  sha256 arm:   "ee414e653c5868fee66f77e4469f5b194e8f3592ad3c762060556bfb762dc856",
         intel: "50fcb6aa9f24790186170b16ddc0336db6d2e4dbb835171c93422208d57a760f"

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
