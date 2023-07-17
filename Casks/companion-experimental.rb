cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6162-develop-0f46f950"
  sha256 arm:   "2b851c13a95514a6e8edb3bc24f6c57d512922902168b87d4ba545c2ed965076",
         intel: "3a0e3c0d5ed225f80f678df19cf2e49f84f20e660bd1b50ceb85d7a5d0df9920"

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
