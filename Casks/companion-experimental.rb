cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6668-develop-41759f88"
  sha256 arm:   "11b0b0cbd93ef3323ac03eaf04b1d9f49a5d1fe4b8d264f8e95c0bf2a325b438",
         intel: "bf99cc4cd3a21fb5681ab305dffcf3d71d1551649e8e6e5b762f0b0dc2d231eb"

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
