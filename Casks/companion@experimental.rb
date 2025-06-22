cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8191-develop-e9e41d4c70"
  sha256 arm:   "9de38798283fc8524d76304cd42f62be603449cb26841d39a7c908ef93fc2585",
         intel: "198b9665f7471d6fd7c4db33187415f16e23fca904377c9396bda470ba526d21"

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
