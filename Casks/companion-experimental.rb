cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6185-develop-0af2a2f1"
  sha256 arm:   "2b8f82357045dbae23e2df8c64a52771847f9b27236e99f16b750c5349dcb66f",
         intel: "9c0db9c3a8e9c9017f9f10b90edab1f191b35aba7594b3a0585121a727571b5b"

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
