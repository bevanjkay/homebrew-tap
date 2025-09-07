cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8477-develop-fc22f01c42"
  sha256 arm:   "e8d3f97e3226c1b6c5e64475caee91b20dabad837b7483298f90caaabda6c4fd",
         intel: "00273ae923ed9ac31c6a9638416e9cb47cfbe76572290b22da0a486168eb94d6"

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
