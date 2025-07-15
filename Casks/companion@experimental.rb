cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8328-develop-f21e3e9f83"
  sha256 arm:   "0efd6cb0bd82aefa93296dd5680a0c0bb8a27aec2d6319226550c1c527d26dda",
         intel: "30e0420028937b28230df171d49ff3deb19f56b13febb56830ea961818f31d34"

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
