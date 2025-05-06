cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+7949-develop-bab440d1"
  sha256 arm:   "10cd0087fff69acf7bec3e55cd214a8c85209c2ff84510e05512c20dc7f19150",
         intel: "66e27377cfefbe479f555f64218b7364be3fac4902a16d7c047302f03f1f0f3b"

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
