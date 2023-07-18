cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6165-develop-0284b866"
  sha256 arm:   "464a269f640d7ad326099f169cb09757ea5d48810c22a44f63e30d38c6ae7e44",
         intel: "6e05e6d8237fc1f6d8661b566d12d23cc0a58dab31669c8e21d05957bf411312"

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
