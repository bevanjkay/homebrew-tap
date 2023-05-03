cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5834-beta-92cd6b94"
  sha256 arm:   "38dc293c7308286a403b76702db20b3c86778fda4565c614d35d82a66b184d27",
         intel: "36752c0d344a26ca736f23f4e65d6d4050cd0e077c5e393a9a1088a26b55feff"

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
