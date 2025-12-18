cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8903-develop-3fb6b808f3"
  sha256 arm:   "f9247778baafb0947cd92343479b609ab3fc86f87cd1e12eb9c99707e6b5d1de",
         intel: "cf6edac0309f5185e297b426862a56a9c0b2eefb9c57b93d10c47714af9c7091"

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
  depends_on macos: ">= :monterey"

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
