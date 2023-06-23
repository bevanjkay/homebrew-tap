cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6087-develop-8e2718d7"
  sha256 arm:   "33215e8dc0f0f8080f3b2e3087abcaee7d0ef140d3039ed8f6238a29245ba04c",
         intel: "51532a81b5c635ce834452831f42a9cd8f2e16aff1a6fce20dec931ebb58e544"

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
