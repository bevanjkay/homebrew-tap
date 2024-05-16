cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7005-develop-18ea2125"
  sha256 arm:   "24113ba6a6b45cfdf9b8fad520b0ee3455263e92a1057d4462310192d176b0ff",
         intel: "0b27953fa16a7c215cfbe0e63c91c15d02d9232603a2432a314228aeaf134c1b"

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
