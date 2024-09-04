cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7277-develop-d23ccbc9"
  sha256 arm:   "be7f532eae6c0ed12b0dd9a1d4c953d5ece5ff350a32436e80ddc0ce931b3016",
         intel: "7cb083a0fb4840ea5d9dd48ac6ee6ab3f85af758a8afb1b0133202e4dfe8b772"

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
