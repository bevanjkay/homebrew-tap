cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7713-develop-89d1b860"
  sha256 arm:   "ed50db770b4b50d1fca5ff99b016dcf001ec2a3a22dde45f8b01279e717be54a",
         intel: "7df91854516a90ca0c63cc7c5a9fedce7e12a0e97ae02435cdfa18899f274bfc"

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
