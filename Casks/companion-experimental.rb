cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6461-develop-1402cc1b"
  sha256 arm:   "5cc314323f08af8dd8298acc7048aba922800fc0909029fc7ad0c6aca2a3cdd0",
         intel: "768be92aeb885923ac642435bf165a04e7667053e0ba090780b1938604ca613b"

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
