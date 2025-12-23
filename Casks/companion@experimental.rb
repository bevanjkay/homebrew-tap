cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8938-develop-9e9ce31d88"
  sha256 arm:   "810419691eb27256ffd095ee8ee95444b2eda81d506a8d1c76455f5a4ec85f35",
         intel: "43a9475c75b91a89b0b3a7f4acb73a8d23adef62333b1a5c789d47ba252047d3"

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
