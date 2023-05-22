cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+5934-develop-f8c0e931"
  sha256 arm:   "d7a098e7c5e61e266c2df9f300e2e46fa82d74e20e74e3a15c9c862afeea2bf9",
         intel: "52e3289debdd135f6b1e53117da9877227f079081562e55e89060a2d0bce9a21"

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
