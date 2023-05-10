cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5865-beta-7f0ffb75"
  sha256 arm:   "d161c7487e21a63347519a9d0c3625c437d2eb32e3caacbf9c8fe014a0ae7709",
         intel: "77d80a2c57b407fc893c32e972919ae90c699cc9ecb5ac12b9d092e30dd1ff9f"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=beta&limit=150"
    strategy :json do |json|
      json["packages"].select { |c| c["target"] == "mac-intel" }.map { |c| c["version"] }
    end
  end

  auto_updates true

  app "Companion.app", target: "Companion Beta.app"
end
