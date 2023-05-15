cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.1.0+5931-develop-e3546050"
  sha256 arm:   "21719b017f6e5d03fe533fa46081e0e4870571dfc41a166ae9040889ab116aa9",
         intel: "1c17115a0224e1310e1399241e1baaaca7647fc4351edbd960b82f7b15069027"

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
