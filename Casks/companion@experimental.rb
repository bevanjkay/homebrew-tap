cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8939-develop-1cb0e1ba0a"
  sha256 arm:   "370e0a60ca5981d654fa065be89b681f6619b6f2140a37764e5f4cd112d7e274",
         intel: "f09237555d5e4f2aca10e80c37cbee371158d8a7324c251a1b6eb4d73cc12576"

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
  depends_on macos: ">= :monterey"

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
