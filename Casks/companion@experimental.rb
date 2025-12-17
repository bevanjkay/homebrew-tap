cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8901-develop-ca6a345661"
  sha256 arm:   "75eb2a7cc7a7b5941c67beb98387f5d49ac986a69ce5d90509284306daf29d76",
         intel: "6e8b3f6cdc36436c9e67cd39f7431a5e60c865a381abf880077a35a1cc5851af"

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
