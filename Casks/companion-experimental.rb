cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6688-develop-d1d4e353"
  sha256 arm:   "8765576745bb08b78307434648cc01afa42f4a093e2906f0b18b31344a318373",
         intel: "56fbf8f7c662799dd55060cd4602daf63bcc7bbad262ebf91bda90ec4e788bf2"

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
