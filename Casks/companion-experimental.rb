cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+5972-develop-d4a2856c"
  sha256 arm:   "96e561176d1779398c95c4ad5412b0acfb404272818b4ab69f5e693ef1a0c3c8",
         intel: "72b2e04d5768a2df3a6744bf9497f247ac3b6e13ce7e845986822ea89720b86d"

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
