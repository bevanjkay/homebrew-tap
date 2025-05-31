cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8030-develop-1447d36869"
  sha256 arm:   "5ea9830aaa35a2048169bb92f8a090949e7e1ad2ad1b89fe747a3976faf48ef0",
         intel: "93308424d65d53952bc5aeaf6c819ef0cf276fb6e21cc01b35c275c27db81d64"

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
