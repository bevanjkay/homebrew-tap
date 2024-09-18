cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7392-develop-dded39b7"
  sha256 arm:   "1842c5c2e606807b3c5bfe01e96a7c66a45fd940d8b1014a892bbde6ac22b827",
         intel: "d3a1f50970a32b74c63c77d2731442fbdcb17a67eb1faa8c31eda25b6b7296e6"

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
