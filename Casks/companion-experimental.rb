cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6182-develop-625f906b"
  sha256 arm:   "fe79baa9ccc36bb6affece32e93ab3dcb36877df2b0ca1016edc02eefec32952",
         intel: "b72d3617ee50490a75fc95b31648e6bccb4fc8b7ba1b9a62dfbb4818258ed063"

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
