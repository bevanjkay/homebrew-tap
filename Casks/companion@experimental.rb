cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8986-develop-5c1f138420"
  sha256 arm:   "b43f847ba0ca8197e9b3a5929fb2e9adb0ba1b475c508f68f6c18cab3170d4e2",
         intel: "9cd8cc84b7eb96b8648d73889ab9d7760c9eaaf9b18f6d17807fb4847280bb77"

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
