cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8946-develop-c53bb1bcdf"
  sha256 arm:   "9ce2a39718a609b6214723a736ad17b70b4b60f58b67e2f09342c440a0064b5a",
         intel: "649edb5021a251d3cf9a667db326b80c274b3dac7ced71eed61e576a825bbffb"

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
