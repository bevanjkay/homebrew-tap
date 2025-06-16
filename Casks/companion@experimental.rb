cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8152-develop-b34720da7a"
  sha256 arm:   "f7cc9301cb961edb8bab5edfb0de1c0ddac788406ed6c9d2b1eb3beac049d408",
         intel: "5f9a4076a3c10ffe892867830662e6135d1e0e26884f182b821671f8d3e4cd5f"

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
