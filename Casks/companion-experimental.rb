cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6370-develop-77ffd631"
  sha256 arm:   "42e7f8aa49f312323efbb7697b7ebefde619503d155b249877d57ff7b731364e",
         intel: "a2f72d33a6c378241e04048f4c2a87da3ded6d81b43d09db95b0de5e81397b65"

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
