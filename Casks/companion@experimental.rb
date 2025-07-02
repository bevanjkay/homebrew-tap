cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8214-develop-25c4bd96a2"
  sha256 arm:   "c38fd39e4f5d45d699cb5c2a2f24c1515e6bf6eedf83de768478f7033d2c65c1",
         intel: "56c855dcd83b5d09ea8a8bef6005b34ac844386e7ed20c9907cab2f2ebbffac0"

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
