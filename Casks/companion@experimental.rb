cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8212-develop-cb908b97f8"
  sha256 arm:   "75856c89e183406e48999eb7a5f3613b8793c35a145d71ed775818d06388c2a6",
         intel: "6bd5e2970d56113bf8821f9a7003f2a28128baca5e99e4fd6dfa85881ef759d5"

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

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
