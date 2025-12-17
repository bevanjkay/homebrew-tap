cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8899-develop-ff617d1a3d"
  sha256 arm:   "d8c916aef7b42667ed3d1c4115f5fcf621ad01af1f73ced69a60d7860a6e0f22",
         intel: "1cdf30dd69435f2645618704c8de76e5a90fdb55a66183d0713f5a7a75a36289"

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
