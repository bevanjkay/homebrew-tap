cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8528-develop-eca3181e09"
  sha256 arm:   "d4a1fb94d3972dc23b0169d83091674215b432b9974fc08a126b1e1a2010f3f8",
         intel: "9d96756a22ba4dd3ccb48704cd7a6e57bd85e18e924f8fdf33306ea9c89663d6"

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
