cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7564-develop-57e39575"
  sha256 arm:   "def532f95f3b2a629737ad85d212fa11abf49c9b66311bd89aef8f476b41d576",
         intel: "8de163f40bbc7723c6f945b4c84effed33325c945e8649bf0b5c4bf09a728cd3"

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
