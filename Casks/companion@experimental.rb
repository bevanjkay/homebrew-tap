cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8318-develop-95310a56ea"
  sha256 arm:   "c79c3d14fbc1327898c4028df0ba0f1afce9362de5eb3ce0113c2456b5e995b9",
         intel: "9045038d2564c8fe1463aaaaf5f5f477c7a52d7fef48a12a4b679963b3bb5011"

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
