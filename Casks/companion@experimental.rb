cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+7869-develop-47286ddb"
  sha256 arm:   "eea357cb04225b5eabde1690e896b8b33ad2a045d899dd17aa398657c40d54c2",
         intel: "8e53fccc20b872218c041c39d2d72ad07e4030570cd14656995467f5af2a6732"

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
