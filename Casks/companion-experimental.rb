cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6031-develop-2f0470aa"
  sha256 arm:   "f56993efbc7cf8157e36858d65f4829fd079810decc18e52e85b6b6760f75045",
         intel: "d04f2d498fba81881db6d6f93b0e89153d66efc3320d257b3c2836b581b14ec7"

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
