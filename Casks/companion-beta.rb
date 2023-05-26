cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5902-beta-1e510425"
  sha256 arm:   "d9d5a44c27082695f140c3cfbb7b848fa17b9e52afdf588ae5177428b6209e2a",
         intel: "e005ab13010eb1d069d7b464adac53584f9e9e3bc746329036b562d0e8dffc42"

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
