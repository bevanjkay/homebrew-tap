cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6091-develop-9a7cea8c"
  sha256 arm:   "0f8ae6990d7e0f5633b6e4bf42ed82b37725cbc1fe3e4a93883fb2033b807352",
         intel: "920bfdf9cfba36bd94d73ad8c08c3971b3ed52cbd1322ad810839dcb8414fa9c"

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
