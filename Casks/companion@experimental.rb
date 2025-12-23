cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8936-develop-9dcb389ce5"
  sha256 arm:   "c8a5cbcb1566232af76cb424fd74ec756d158bc02011a1fd7a6b1c2294f2f108",
         intel: "62656cd258268868ceccd7454e67d690dc2865f7f4b9cb18fb0738a1d5b939f4"

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
  depends_on macos: ">= :monterey"

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
