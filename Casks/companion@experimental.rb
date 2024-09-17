cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7388-develop-7cb45b1f"
  sha256 arm:   "485516ad8684c88e06da4bc2fde2bdb989d8ecff64f12d32279cfd27b25f1ac9",
         intel: "9e7888b1289fa9a5768ecfc8020a839d0254547397ca75a6cb4931e84a4c6fa4"

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
