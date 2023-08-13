cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6216-develop-213ba884"
  sha256 arm:   "5ee1124da81a75fed66c72a2e842b0232bdd7e3b57d86ae632757526ceef27cc",
         intel: "54e0894bcf98296a75dbfb0168dc8a4ace3c36b52fff9d9b786e46bdddabbc2b"

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
