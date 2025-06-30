cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8208-develop-3918d1d1b7"
  sha256 arm:   "d9f26bef465d79cbc50f5c675124fa29a6e24fbaf9daf9af92a5c4f96157618a",
         intel: "3131b15deb7e9a00fed7ba6a7d128f12584572b2a571338adc1603f2863ca366"

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
