cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6503-develop-93dad4b5"
  sha256 arm:   "5f1efb0ca99151be03d361d6c7ef05bde066edf7e2f7d1aefcaa1ca67c7d2204",
         intel: "57e230aed46ddba4b312cd41df656338e21fbe7d13944783e3a8cdea10f737d2"

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
