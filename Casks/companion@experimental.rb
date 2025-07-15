cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8338-develop-ebc2bbc976"
  sha256 arm:   "da23cfe229da524c8bc72924de06f45bede0da609ee5a576b9ffbbbb2accbd8b",
         intel: "2846fcbc102468d98820354d5d61ae6db2b3f777ed74572be9f5124172b39322"

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
