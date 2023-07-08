cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6026-beta-e6aed9a8"
  sha256 arm:   "68bbca5543a5d45e80e68b7c916739fd3d4165665bc853db1caf6aa35073070b",
         intel: "02048d75bb2182ea7aa8f1aa5c9b32ca345a0c6479339bf89e8418c246667285"

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
