cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5934-beta-bd3fdf25"
  sha256 arm:   "4d917d7663b3772735a5e9388fb4989e7d6a257a9c4521b1a47cd872fb4d20ca",
         intel: "d5fc0efc895dcaa3f93e6c6b57232b50be1d0fde3e190c6d9c035f19ff242eff"

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
