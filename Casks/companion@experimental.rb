cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8546-develop-1abdcccb16"
  sha256 arm:   "59caddb881147d9657278a9128549f9e87ff343ec227f45f8dbf3dd92b97c7b1",
         intel: "5ce4fb4c30434684d59091ed99b4cdf1eaf92248ecdc43eb739363f5cbd71939"

  url "https://s4.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
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
