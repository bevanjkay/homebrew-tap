cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8904-develop-181e2490b7"
  sha256 arm:   "24cfc656d74f7461b358cd1579427952cc1b33c01b82f53d45adb664175cb838",
         intel: "2ca791f474fadbe8220d4ebe9d8612ac309d978b92184ed003f0fab8a8c584fc"

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
