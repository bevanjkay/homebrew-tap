cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6732-develop-996c863e"
  sha256 arm:   "5f7aba35568517decd7a0ea20f2615fd453f872dfda042d9ed2c74f0a7f76df3",
         intel: "9c86eb8270c80a1019c23bff1c631949a1afa7ab573957aca7581350c2f51a92"

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
