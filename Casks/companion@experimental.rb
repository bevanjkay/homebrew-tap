cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8211-develop-5ec8417cfe"
  sha256 arm:   "9143b1a3285e98be8ab1d69fbca2d4a4fcc59dd1adb34083b269388c44963a7b",
         intel: "2c39ea631ddc4adec96898d3caf35a47d178a432acc08368cd12fb176af19e39"

  url "https://s4.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=experimental&limit=150"
    strategy :json do |json|
      json["packages"].select { |c| c["target"] == "mac-intel" }.map { |c| c["version"] }
    end
  end

  auto_updates true

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
