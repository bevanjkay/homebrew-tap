cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5920-beta-9cc0ebee"
  sha256 arm:   "a406634d7f9cb83b096e71e2a5983b931ab105ca32d2051b901782e503fb1ba4",
         intel: "262cda04c2b4a3da5cd2c7198db54d9850dc9187a9c8ff8d1f7f09af49dc26b6"

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
