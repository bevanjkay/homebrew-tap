cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8166-develop-6b1f0430a3"
  sha256 arm:   "133306deee4848f03a2194c654589194e9247a8e1685527bbc83a288d35e1c35",
         intel: "8a1686a0d73ee208ea68be949782460760abe68c5934e6702c572cbcf87695b1"

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
