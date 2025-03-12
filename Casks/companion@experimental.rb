cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+7888-develop-00cab3d5"
  sha256 arm:   "6eb41b27744825f685a2715e3a49cfb914db248d269b1b85efef6764395c3d62",
         intel: "ffb96b0e0da9b533566a593d55c0f8822a17c3f49b12dfb580b5db40a0dd9d0c"

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
