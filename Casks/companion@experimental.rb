cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8948-develop-8f57f99218"
  sha256 arm:   "5dffb24d2da80ca35a2d7ee7b43324035399b28c2970be9d079460d7fc2d89e5",
         intel: "1ae4c84c210bdac3faff34084a851f4f1b5ea9f9455b010a5ba102a1e0007cec"

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
