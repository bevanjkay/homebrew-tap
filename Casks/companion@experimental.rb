cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8573-develop-55929fd1d0"
  sha256 arm:   "828be72331e68eef56e8a542013530d67e2348517eb6fc04fbd6e30618c87667",
         intel: "2d404423604195a73807816283a090ea75bc57725cfdba0b96f76398f18adeac"

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
