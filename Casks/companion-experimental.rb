cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6215-develop-836bed84"
  sha256 arm:   "43d2ff1a02b391647388f204d30b7aa8b674a03d12995353e8dd99f33d338e57",
         intel: "6627e90e8c21e1515b0ef99ca7896ef7efd2ba09451d48b68c0ad91c21524d04"

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
