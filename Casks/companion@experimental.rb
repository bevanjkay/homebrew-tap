cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8551-develop-ecb59a2619"
  sha256 arm:   "40f829b3d39022ec8d2aa0a765dc36e9d1d3e436aa56c751c6af43a92f5752a0",
         intel: "78a8989ffbfd75203697c035179aba6a325b56465fa5359a50175eb9e164c82c"

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
