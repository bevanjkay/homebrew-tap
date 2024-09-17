cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7384-develop-498674da"
  sha256 arm:   "702c153bfda1633d92ed75ff0ab2b8ead7972bb38e409f6bcb7e1b399fa55753",
         intel: "96fc4f6d3c44f07cd037ea94764c06b9196deb55b0429565b3e59e08a55012da"

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
