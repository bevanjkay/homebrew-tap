cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6187-develop-b7144a02"
  sha256 arm:   "1222842fb9eaa5da4974d1e1b078deaec989330876da7b12b5981eb6cb955bd5",
         intel: "1e603444ecfaf54226a5996313635dc21bf5f07331ca5e596aea600358008df3"

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
