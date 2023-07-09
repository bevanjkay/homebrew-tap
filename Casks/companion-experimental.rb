cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6135-develop-31576feb"
  sha256 arm:   "818dfbed58f61ac9c0ac119bb06a3424bd6677868e0ff6e1550478eacd4dd9a9",
         intel: "8486c6674182cc78a3a9c85cfa141d3e785270b0d4c439cc28b9ff7957344331"

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
