cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8391-develop-5343ba5065"
  sha256 arm:   "92e9382bc824bf633c8802a558e07890c391fcda9de07ca139282ab7851efa4b",
         intel: "f585ceec989aa3f9a69d9267331fba2df0249d4be83e2371246f2d7695f2536c"

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

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
