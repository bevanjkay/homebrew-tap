cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+7787-develop-614be230"
  sha256 arm:   "5de27bfd55eb3ff6e484f786e329914492c960c32b5b8a68ad17b26c14f19724",
         intel: "68d495aff69ddc3ff46bb4e28bd1e1001a9e25efe8d775362806df2a41c10824"

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
