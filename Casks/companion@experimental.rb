cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8931-develop-140c91b611"
  sha256 arm:   "bbb70ed0dd9ca3a352e4a16d989f9f2706da261ca47dcf3e0d034cf4d1dd5fcc",
         intel: "9bc5ee9c631194c6dc65d4646cb5812c7cbb9d71ba3e8dc5bac4c22c23bd10b6"

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
