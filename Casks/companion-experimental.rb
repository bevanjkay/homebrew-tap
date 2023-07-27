cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6181-develop-b7c5f516"
  sha256 arm:   "fd8fb9946edf761cb38479bbfc277ff1f1dc7592d7de92ca64da27b67a2188aa",
         intel: "763f8f5b822b2580eb9db2722a40f428cdf2adbffb86bf722d9b849fdf0f3e7e"

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
