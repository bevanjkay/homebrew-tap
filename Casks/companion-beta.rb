cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5835-beta-9ba5faa6"
  sha256 arm:   "0f41426f5d804846eb8eb18570e7a06f914539ec2b3a99ad4720a472962d6d55",
         intel: "5539b611a7a4c786ce2d13ba12f8f85e78821a4dffba5b1b10f211941986215a"

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
