cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.1.0+5866-develop-01052eb4"
  sha256 arm:   "6bfb7e6b275c970dc793586b0502c1a041c617375851a49b6eccb9d89441d79b",
         intel: "b7ea0d84a9faefc8ab89c653258a64501fcf47fdb663edbb3ce40f77a30469c6"

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
