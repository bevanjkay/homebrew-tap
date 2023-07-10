cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6136-develop-0ef86a1d"
  sha256 arm:   "619dea20ef63edb18ea310ca7cdef17df00943c29ca60fd3d1ab8dd9db059f78",
         intel: "fb8a048f1885454b917b0b8ca92b7027da117af7fef938820553b7455d7f2468"

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
