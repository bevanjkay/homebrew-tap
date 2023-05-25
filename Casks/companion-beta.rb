cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5901-beta-c4b943f7"
  sha256 arm:   "f2ccdc49d022ca023ada682ebdce9c281d4075e66d13c9a673d71bf151f7b1ca",
         intel: "5f2248dd9b6ba16716ad4d3fc6cef7cf3ce74d06386fd59e836380955ea9b4ef"

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
