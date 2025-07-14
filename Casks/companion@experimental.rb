cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8309-develop-ca74e91c7d"
  sha256 arm:   "24a6511181da068208e4a60a96ce5290c190490658d1e988028d81d5f335f520",
         intel: "2d465a039e57567e31c9ce4103b891c04c5d802aba87239a363619766426f3db"

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
