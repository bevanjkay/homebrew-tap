cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6502-develop-3fe2c00f"
  sha256 arm:   "f1c7632ef53888b414a46a8cb592a5bf64da2a44308c41c54b839f086ade5a2b",
         intel: "b9250c46066e057002498ae0bc2bf34b630902fd42901f178bb097c05ff19738"

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
