cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6372-develop-bd663404"
  sha256 arm:   "e4195d438793870306fb4e9541e355be9a4d69d56812687154ccb2fcb9ce97f0",
         intel: "2feaefb603496fd42d87916ffe74a21e2874b3a9b3a26ecb5cd48ad412f88c04"

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
