cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7112-develop-daad9b55"
  sha256 arm:   "08c45e19707722d9c636b6ad8799d5daaba5d81ddf0b49a6a130d74e91eedb77",
         intel: "900f652cbc579b0989d744caf9f1e04248c6b75430ab6b15270f4db68a8ffe80"

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
