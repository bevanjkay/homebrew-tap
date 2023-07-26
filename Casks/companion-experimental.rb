cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6180-develop-dd5d50b8"
  sha256 arm:   "628cad76f9b5f31dce06b9640594e2955ee5f08ff0ad283ac01b80ab1d162b32",
         intel: "ecb65235e4bed6d321d5a2bcd8816c3ffb337affa033e76f52cec784a4ee3f0d"

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
