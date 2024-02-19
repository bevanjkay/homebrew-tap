cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6782-develop-f6a3068a"
  sha256 arm:   "ead5896b9f210a9060b4c6820ae60aad78aec67b07149e2f8aa783f3c1ef5b99",
         intel: "c3d0d3f889587f27f6690078bfc93e89ba3f6ba09ee365a2d6f9bdd4c6e5fcc9"

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
