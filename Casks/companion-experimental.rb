cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6179-develop-07541b9e"
  sha256 arm:   "b81b9a57c69737fd47302adccc0ffc020422b2d086b074830ddd3ab852ab7322",
         intel: "8fe5cdf3bb077674e0a4882068e5236cdfcc7d450a265e6488037be607105902"

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
