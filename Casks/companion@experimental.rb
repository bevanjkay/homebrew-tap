cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7707-develop-17ec23a0"
  sha256 arm:   "80d4ebe299f1425c5300dd051d427ae716d07944e2a87549a7aa35452de9117d",
         intel: "65df5fcee485ba4ce30ede2454c0587c43697ee4d90f768964208cc30634ddcf"

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
