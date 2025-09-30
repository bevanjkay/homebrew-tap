cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8552-develop-8042a5292f"
  sha256 arm:   "db006f5db9082f5ce9e520b4e2211a8631beb4cb70b1a67b185938333d138d05",
         intel: "6fa1a6ae08d761d4f66340c556253daebfa92c6d04574bf3144ac202c6907067"

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
