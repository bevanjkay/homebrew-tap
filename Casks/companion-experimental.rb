cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6257-develop-abf9c43e"
  sha256 arm:   "2b6b786e2a331b29aad05f0a7bbcf6a31612e94170f64a66daa7ff43d96293cb",
         intel: "c444ad67e2bf3fc24890a34436237a289c51661b36e65352a37f135aa0f6a126"

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
