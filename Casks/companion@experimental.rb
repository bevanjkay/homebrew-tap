cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8329-develop-5ecbafea2e"
  sha256 arm:   "0444ac25e1c53e3c4cf9a2aff657c797aad129cc65e075209697a13de128d684",
         intel: "f19da2a605a66b5c8ce5586214747df0ca2e9d9ba4ccef4661efcebfc6b0edf2"

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
