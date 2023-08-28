cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6275-develop-e54c9bcc"
  sha256 arm:   "32515d9af1ff1a0dc9839bffdc4ff3cb837352f851a9435115e6b3a1f94a50ea",
         intel: "29f3e9a16ee8a742d6c1cfe90604918bbf18e09c0ec0a1f8514f33e3e9d15142"

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
