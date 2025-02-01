cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7781-develop-8cb75164"
  sha256 arm:   "dcdbeaf1a43bc46e18221e236205758c8e91854f176bafb7bba78a2152f09fef",
         intel: "20efec5915801ff3ff967db8dd30de80971b3d2b0bf7e8b8250faebebf1feda8"

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
