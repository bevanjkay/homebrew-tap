cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6431-develop-0ed7147f"
  sha256 arm:   "134ef3e2fd79f8c61fabb4f4f4e4d6238731638d8520fb21730be30da4b529b9",
         intel: "220c93ed9c2dad81c771682d48c8513bad993d9d61f188967616113fb8b66f25"

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
