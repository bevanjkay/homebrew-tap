cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8138-develop-530acf6fb4"
  sha256 arm:   "ea005e160e9ddc7952f3f8ee9ae5fcc322f53f20fc91fbc1ff47459ba6fa381b",
         intel: "4ab3a2e6e14c161f77fa9372fd15bd8f136641c575be1211495ee656a84ba665"

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
