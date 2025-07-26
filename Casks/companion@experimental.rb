cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8395-develop-9a102a7b2e"
  sha256 arm:   "b715622969bc6cc90607f0b5799edfa4c25c2922e9252f484f6720cbada486d0",
         intel: "f41eccf54a50dea3fa0558bb766351b0e6c98466d8a07aee5edd4309bc370882"

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
