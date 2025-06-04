cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8067-develop-212375e93e"
  sha256 arm:   "5cebf9ea6a3e06ef62bc3ee06e4a8ebdd01dc47db2867bd55ae0faf5c8c97533",
         intel: "b34f037b09eaa43b3c6a3eeb6e0a77ed8127657acbdaef175558eae8f1a77190"

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
