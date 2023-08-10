cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6214-develop-47507470"
  sha256 arm:   "ae73334dc3361c7f6fb2d60776176e2a631e1ab6a28df48ed01bae2b08b54632",
         intel: "a385ff7771e04227a1f5de37386c895a03142dda5d54086c5229594bc03f0ba8"

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
