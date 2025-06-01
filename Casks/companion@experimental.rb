cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8037-develop-db18f9d1c8"
  sha256 arm:   "4dccb5958b28e0be06cfdab8a7adcdda5d955c0fdd3d5e95c6b9ee48eb9e0637",
         intel: "4fee8b85c1cbcc1db0071aa9840a30d0a5c524636e944bf77ba84ba3b907d6cb"

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
