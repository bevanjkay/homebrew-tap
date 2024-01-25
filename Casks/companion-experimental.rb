cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6689-develop-4fa79fde"
  sha256 arm:   "d0638a6d4f1f1240ea5da9f3dd34df06c02511e73be4812771196c47684ab5f8",
         intel: "3a52e34c5f7a2fd0945d77caa58f9c19883132ce6465d52f4e78bd7ecbad1263"

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
