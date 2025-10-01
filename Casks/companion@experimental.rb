cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8565-develop-286c9179ee"
  sha256 arm:   "3c838d47ba289c05b7c7ef039fb609183c3ca3a9104b00bbf4380f6cee55c3e5",
         intel: "c1e0e8db558f7b5651c4918e04a80f9be0580004e2f04b13d08d73589c658628"

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
