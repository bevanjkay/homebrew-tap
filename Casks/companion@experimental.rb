cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8989-develop-43491ed7d0"
  sha256 arm:   "d50a06d577c29789d26128ac019e9c15624317c385f2408599b85b7070d86d59",
         intel: "a92d5329281a69207558e43bfe37152f5642fc8f3f404ff348b392abd5637230"

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
