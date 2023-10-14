cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6414-develop-3e66d42f"
  sha256 arm:   "8ed2062f2e5e5a2f4bf1b085053e76f6fd109e68f805e5fff9e98c39ab9219e1",
         intel: "ba144b2e099ebb8429f682a2bffd3843f88609816c57d0f29471053f97be3e33"

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
