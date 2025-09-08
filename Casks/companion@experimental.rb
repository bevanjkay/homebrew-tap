cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8480-develop-01ad477ef0"
  sha256 arm:   "f46c10d94294a68d24f8d4162e9a85ffc21891532667a822526abf0d38972573",
         intel: "d2c558898bc756016f77060115b4cb2444f92bac3f20a3c2f5acee317f66c0b3"

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
