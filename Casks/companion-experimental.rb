cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6029-develop-3f154b12"
  sha256 arm:   "ef8fec052dd4049b3e57241453bb7acf1636d20d7d39858157f20a56f87f3ce5",
         intel: "09edbdf7194f5656fb38d8931f6e94226be5acd1ea74d4fc26842816a0b1c1a4"

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
end
