cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8902-develop-72bf22a0b4"
  sha256 arm:   "5a90a9d446e259a9274bd870a3f32e9c01acaede4f0457c6e4f7fda0523888ac",
         intel: "de436493364b4861c578ad632a8dd64e5c7ac7da6e302af09ffbde14ec672a9a"

  url "https://s4.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
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
  depends_on macos: ">= :monterey"

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
