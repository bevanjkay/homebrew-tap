cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8381-develop-2858f04679"
  sha256 arm:   "7e62bcf613aa8674060c269f0b4c317cc1614f21f40be94fbf3d4ad0d5fd97a6",
         intel: "e84619c2780f14c88822b59520c7c7524250dd7aedf38c9e384d40e0b3788257"

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
