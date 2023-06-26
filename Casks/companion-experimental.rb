cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6090-develop-6150e233"
  sha256 arm:   "0ecd20a4c1e1a57080e6fffb12415824f9e69edf0cad2d1932085d6feb460310",
         intel: "834fa3111a68703d07823031739b02c205bba9aecd3afb66fc65b35f0a70158d"

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
