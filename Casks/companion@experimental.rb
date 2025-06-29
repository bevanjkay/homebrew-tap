cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8203-develop-87ff2abf3e"
  sha256 arm:   "7118925ca6c8bc7b1316acb4a5a7ae79b0dd6646e1858964d6d83f461b6083bd",
         intel: "3461e5d943b1bc310c3323bd475a3a67b5f938f9c135afdd4b6b8f0a8825f6be"

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
