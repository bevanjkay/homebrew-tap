cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8066-develop-8807c21944"
  sha256 arm:   "1476c56f3505f274fc0a54e2169994f242c741b918d274a561bdee861024645a",
         intel: "ccb507d042569767fbcabd490faa712f695925d0c3cd8c3905436773b3fdf5ad"

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
