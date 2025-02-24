cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+7874-develop-0c3b247f"
  sha256 arm:   "71884602fd0ff5229f5892877395490c90c25e8ee6a7f33b2314178929eaa423",
         intel: "9dd7ed55e7bf5924ffa4e7ab40ef1075b5ce2610f27cc3fd69194ec0f4ac83d1"

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
