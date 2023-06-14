cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5941-beta-6484c2a3"
  sha256 arm:   "5ff9d26a4e417ec64a0a699ba16e2355a4e4b996d2ebf04bf465226146a357bd",
         intel: "fcbb59d2b28ce323a0f4e5e9e313531ecc3b23757e3ee23cabdda9d746bb6cec"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=beta&limit=150"
    strategy :json do |json|
      json["packages"].select { |c| c["target"] == "mac-intel" }.map { |c| c["version"] }
    end
  end

  auto_updates true

  app "Companion.app", target: "Companion Beta.app"

  postflight do
    system "open", "/Applications/Companion Beta.app" if ENV["HOMEBREW_OPEN_AFTER_INSTALL"]
  end

  uninstall quit: [
    "companion.bitfocus.no",
    "test-companion.bitfocus.no",
  ]
end
