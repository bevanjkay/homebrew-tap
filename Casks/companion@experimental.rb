cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8548-develop-e3c9745129"
  sha256 arm:   "bec1d1459b24388d7dc4480807744c52958086eb04d6d9de2cdae380302dc486",
         intel: "094b4ea6500336ef3571d8e23c255c8b1d9aecdeeffea942874033678721518b"

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
