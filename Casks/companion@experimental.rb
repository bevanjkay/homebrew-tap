cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7726-develop-4f30410a"
  sha256 arm:   "b7061df63620446175fd89654cf622b11ad372534c57d850eeaa570b81814b55",
         intel: "098b6a10d1df76b85b8748a52bd8d3b054eb16e1d9b024e12d7a0b6fc1cc6ae4"

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
