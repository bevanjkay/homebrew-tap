cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7323-develop-49dfb0c6"
  sha256 arm:   "da5cdb56e4d056d0852bd5f96fb7e3f043b707061adc1dc3836d2f72baa34523",
         intel: "60554f6642a865ff242ec125a2673eb919aae1abc056d6fcf8435813fdb82522"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
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
