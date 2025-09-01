cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8445-develop-2fb2de5f20"
  sha256 arm:   "40927d035d234a8b578f9b21404f3fee739965a764dc8e21f203e16d6d486fc0",
         intel: "d3d4d1582a2267b425bfcc0db6b53d86dba797b7703d61b3a4bb89a9fe0ad92e"

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
