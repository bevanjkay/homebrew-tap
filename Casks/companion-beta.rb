cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5836-beta-56757ca9"
  sha256 arm:   "6c2ab7ed892166fca18fb1dc065eab89c84eb7c4fe73a301eedfbd4628c98003",
         intel: "21c37d451d5145d5e7d9364609a6f111a71a0c5bbc5e8758f8a0bc6bc90420ba"

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
