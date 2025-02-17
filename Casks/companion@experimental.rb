cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+7865-develop-92ac08dd"
  sha256 arm:   "7604c7705c186952b6e32b0ec207890dc52a8f7c655593b19b6fae0f48bdaa7d",
         intel: "30af7136301d52b32123009678501f18782cfbb84fce45e79254ec6f6705d560"

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
