cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+5932-develop-1ff8a97b"
  sha256 arm:   "26486a51b5da839e338481ed69c8dceb020f28c4d3a9e0a6cb2496b1fb53c61d",
         intel: "2240fbf0392cd069a99fe0e3043b4a64b1c2a94a84e1c2dc55ef184781036098"

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
