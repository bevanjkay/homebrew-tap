cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7708-develop-984f43d4"
  sha256 arm:   "067e40b708b5632208749e343118e86e082bd976ac7e07b3e22f0f274bbe51c9",
         intel: "87142c69e11f3ff6ecfe2caf8688d307474b0bfbab46317c504f362c8cf8fd77"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
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
