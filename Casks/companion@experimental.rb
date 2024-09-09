cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7315-develop-3af86b4d"
  sha256 arm:   "3f5148c57d402bca2c426315fe710a95805512ed0d90bb84ae3f4269ef1123fa",
         intel: "09794a7c396e56afaae81ca0f1fc3581569135ae4c5f04767d1e0480c3798375"

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
