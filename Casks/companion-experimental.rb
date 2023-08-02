cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6183-develop-63cbe7c1"
  sha256 arm:   "35845c92e76ec1f3530624b361915dddd91dfac575f64decb4b7cbd4252fc500",
         intel: "caeca881499d14ee302716dd69417f6d8c7feb8c90e0811dec9f7226a0b3580e"

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
