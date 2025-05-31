cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8033-develop-2b554bb4d9"
  sha256 arm:   "cd501dd298327cc3ee85d09548f223012274e07bdda4d27be280bc9f0da5bacd",
         intel: "d1848f5b1be5279b97754b935a60605f21d272f4e01511c0e801da7b9c54e668"

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
