cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8063-develop-9024f06ac4"
  sha256 arm:   "9b8b5cf191a913990c40581e4f7b79b7699761110d10ab00f2ecbac5d0bbf688",
         intel: "a2b62b85f41390c4683104449da3db22e6b871bcd02064dcd5133c8f3956612b"

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
