cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8207-develop-a4b1517dd5"
  sha256 arm:   "e7ef4f1d34dfac14aa36bd79490c4e5fce991be9552010b5070d8b50b5529aa9",
         intel: "2fff6f87c9382ca3324e1f9d2ac8df4f28e63e84c6135634d9747f998d3b3bb1"

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
