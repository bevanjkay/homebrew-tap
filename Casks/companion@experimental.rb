cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8476-develop-da00dc8195"
  sha256 arm:   "acdeb443b57319b3474724a4a4efa0673a3539c79623c1f0441a2948bf4855b4",
         intel: "ec593ce48424de3bbbf003478765e6cee069cf0b5b20047ab338510b3594fef3"

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
