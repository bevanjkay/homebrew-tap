cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8149-develop-46b1a0fdfa"
  sha256 arm:   "e2474a1744528ed7b30807b819d84804fc5e09991377934324969726ccd4d407",
         intel: "40545845c5e2019a212bf764f0f4115b04049a6b403ed47838cda8c404d2eb84"

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
