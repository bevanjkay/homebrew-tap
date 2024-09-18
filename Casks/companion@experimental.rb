cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7406-develop-3d40d413"
  sha256 arm:   "e12f88b948244ddbc2979350cbee39bcc5392ee25d07ed67051fb2a3fdb61af7",
         intel: "2bf0c69c2d40783dfaf08f078fa0c0f2cf69a2aa47b948322d3966fb6ae0ef5b"

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
