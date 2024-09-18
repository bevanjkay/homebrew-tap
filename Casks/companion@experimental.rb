cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7391-develop-d92b1204"
  sha256 arm:   "3606a794722917e22dc4e2fc314ed67d415a8027e3413aeb73ea4d0aa19dc4dc",
         intel: "e9d9eafa7ef273365a503171b033a0a059f8d5118ce593cb989d7c36319bf7cc"

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
