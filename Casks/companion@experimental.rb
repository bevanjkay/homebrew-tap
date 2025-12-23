cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8947-develop-d4ae6f890b"
  sha256 arm:   "b2765247fb018c8a56bbd3048179cb0b391df41b96fda6d50b08ad9c20319d69",
         intel: "2936b950d2d983ec049dcea4f20e5e0a9607510773aadc6b6a43ebea5210281c"

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
