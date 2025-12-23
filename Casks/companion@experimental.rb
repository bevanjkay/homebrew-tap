cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8950-develop-dad3d3d701"
  sha256 arm:   "5de680114b7908bf3eee6d9ec4dc6ab0ac80c3d92c4aa14288649480022c636d",
         intel: "2b89892302b96517f63689abdb2e9504182318066e383eb5e043061e3f0f8027"

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
