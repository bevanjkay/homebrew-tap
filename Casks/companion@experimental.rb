cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8922-develop-807f8d61d6"
  sha256 arm:   "0afd16b9764450ef5ad31833092e863c412769d0433b493d8943360f45f04249",
         intel: "715da3ad27bae6064402e710ab50634bc26806765aedd6ac61264c55dd987678"

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
