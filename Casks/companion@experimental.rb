cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+9008-develop-e5fca32474"
  sha256 arm:   "65256d852523e430af81411060f383f093f3ac6f01b3519056e9f250c1e479e9",
         intel: "be572ff75383ed7b6cbde4d792ae08794f56501ca50f28f0534768a277d7da92"

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
