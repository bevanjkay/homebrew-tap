cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6316-develop-726a08eb"
  sha256 arm:   "ac8158448ab0a01969be91d5476661c00951a346b354bb7ba65136fb1e44b841",
         intel: "1633e46246677af7a318443f2dbd87db3fc49ead376abac94e881a08c8babfce"

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
