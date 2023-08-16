cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6242-develop-5ea6c5f2"
  sha256 arm:   "fa5879573ebcf6f9250110e542d179058421ff1c69bb796c5943e3e5c58b200f",
         intel: "95cde70d371f1db3d2c188c2318ac6559a4e7dd4bdbc70136d2c16c10dca871d"

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
