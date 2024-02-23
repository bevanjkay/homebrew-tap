cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6806-develop-9ccb6d95"
  sha256 arm:   "fa8a65ef783e7c01be3370f4f8b85eadee074fc7eb60af48828450d72e34f991",
         intel: "1086caa73f14ab9ffe07a55170faa5f67f0d55a41a2fe8038779066ae8b39627"

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
