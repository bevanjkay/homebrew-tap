cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7104-develop-9295aa59"
  sha256 arm:   "536208360b053c9b0a919950d77f19f6bdc2d40492c6d58e928503c55f637ce3",
         intel: "659664e4f0e8db3d27fb194f7909827ee99ed7a4b5a7c9b6741d9a1d391f7efc"

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
