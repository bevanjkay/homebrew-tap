cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6258-develop-64d5b8e8"
  sha256 arm:   "d0e7de7f1f695eef6a0df7bfd18dc231984ad3248b1e19b60cc2be69a7168aa1",
         intel: "feea21058d5017a8334565be4997bd664ab24c61b69f1b46325b99194e691958"

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
