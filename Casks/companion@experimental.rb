cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8036-develop-fb9fb8c823"
  sha256 arm:   "e89801d4a621ec2ecab7dca131527ce4e3b5bd27b6de7e0bc6cbbdd5f0fa865f",
         intel: "31bd67cd543ae5645f1e450e4e54b4480dc0633da94d01f7920d3802e436dd56"

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
