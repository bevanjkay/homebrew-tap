cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6315-develop-e6f7ee4c"
  sha256 arm:   "f2fee9376401eb7768ab97788a8e0d1dcef58ed59d8e6b85d055a3477fd6e8e4",
         intel: "df9e1b373abaed78d1883c3e6f6da16c1d202bdfa0db7e8f3a7191bc6a8ec629"

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

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
