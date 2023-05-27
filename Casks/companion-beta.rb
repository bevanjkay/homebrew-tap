cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5903-beta-f980b4e4"
  sha256 arm:   "ca562680c152126dce231bd96c3ef7a19e72b39042c5da5d31191b434f9fa1cf",
         intel: "3f289b7f039173fb2b08f3e583e446a5a5e3cbe8f39d22b69ff4dab4dd13c03e"

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
