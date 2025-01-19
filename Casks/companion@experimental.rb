cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7709-develop-53fee393"
  sha256 arm:   "125e42e2f343ea7b91a666c4ea0690b0a6b8ecad86cc6c720fe4f37c596824b8",
         intel: "c42e9bb4b57cfe6032976fdd04e9d1d3b545ed1f75d27843c186b13c19d7c91b"

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
