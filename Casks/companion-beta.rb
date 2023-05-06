cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5843-beta-d1cd3911"
  sha256 arm:   "dc8784344d12012d523b8afbffdb440036205a9b43c935089b212fa62fb77e42",
         intel: "795d178278aad3c40587a8f5a212a2dec34bb25cdb794bc7d65bbe3df5f558c1"

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
