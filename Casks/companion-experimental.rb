cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6403-develop-c7301af3"
  sha256 arm:   "c0d7129c65102ae7a70adf84a5f7fa4eab009e7a495bff1cce3f3a7d3f3c3b6d",
         intel: "a481be3df64215b9cc815bd6d77d2d09f8b2ecd5fc76222bdeab9b413fd4ff94"

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
