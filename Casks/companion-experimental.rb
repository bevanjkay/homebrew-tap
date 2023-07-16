cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6160-develop-8ecf7036"
  sha256 arm:   "bf63d433eb65d185ef14bb6d0e85b86ea7aadee9051d10143b7c64c2787b623c",
         intel: "a572bfb6353c5580fb08655ef44a9d303aab64d9fa0e664fe611c7ef2e262442"

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
