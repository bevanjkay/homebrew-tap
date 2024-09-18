cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7393-develop-941fcc10"
  sha256 arm:   "5ded95d3d44329a3f3a057e7a63fe54509f8ea3d1dcfdb2ae91e7d0e3b0a3d76",
         intel: "7059e39713e526ba860bafbb86d99698ff13d8b03abba1df0c798499abe21d76"

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
