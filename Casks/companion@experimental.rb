cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8137-develop-ce6f471464"
  sha256 arm:   "38cb597ea93c268c12a21459847ed6ac0d46d0937b6cfc5140dac8e888d6635e",
         intel: "312857021f43c912cdbc6edbc88ae6d1bfb6cda5b4daa7b8137249297d8cdbbb"

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
