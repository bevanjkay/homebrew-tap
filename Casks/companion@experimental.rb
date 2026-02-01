cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+9085-develop-0bd0542c2c"
  sha256 arm:   "b48e42d23e701aee05f6bb27eda6f9397898948fe5fc1b77e78d4053fff3bd57",
         intel: "ffefc027001326b81c581699cc4f49829b24c3b9a588d60b5442c5d23ae006ce"

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
