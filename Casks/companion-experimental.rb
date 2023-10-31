cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6459-develop-7780d620"
  sha256 arm:   "21d00e2c15ff81baa29d62978b8e3bc0ba838e17da02e0b11019ad12111ffdc0",
         intel: "b4664163b5907f407e03d58fb6521c2003b0dc8d86e4e0e9ede3eba92b7e36f3"

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
