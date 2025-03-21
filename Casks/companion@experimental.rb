cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+7908-develop-dc9daeb1"
  sha256 arm:   "ef95014b5d76184042172f5d09646c5c8fa48c0a1819e1667ac32106cf8d156e",
         intel: "05fa009a9ca2f0f7e03e0600954f7b52ee17f06888837fc8a60e051d1dd450df"

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
