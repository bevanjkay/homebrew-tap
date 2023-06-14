cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6030-develop-87463825"
  sha256 arm:   "a225e27edfe63926a86eb08dae596f6aa800ce97e608609fb0535faeba06867b",
         intel: "3c2247d2344e21f23065f8325bc8db0f64bfe46fe19232eea23643a5ac247eb0"

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
