cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6116-develop-be0f083e"
  sha256 arm:   "cf6ee4b0df81f90122fbb91c4a6f2308a5015ffc84bf0eaa5559cc7008816fdc",
         intel: "07cd94788c75379051d3ec5fc592764297f705e543d85ad0933bb8484a62b8f1"

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
