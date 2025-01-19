cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7701-develop-f43e4d83"
  sha256 arm:   "f1c626d296196143d29926d1c7bf62afb5f01966db1dd1c4ebdd3f34bb874929",
         intel: "88494583dc7e3822ec6884e4890fd8a2cc9d76c00e0255f5702e7265c9f4a5a5"

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
