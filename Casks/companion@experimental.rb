cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8215-develop-f842d1bb2b"
  sha256 arm:   "4bf9ba77df6f775d6e4cd2d7543eb583feb60162cef418a203572a96474ca1a3",
         intel: "07ff8d71dd2d3ef66db281cf4076bc8dcd4999e9fa0956735ce2356ab8da81cd"

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
