cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5951-beta-06d6aaf8"
  sha256 arm:   "46bde38e6fd24293765ff96f08cc3b046293dc9d81ee157c36b2ac5cc126c9ec",
         intel: "3369a6d6a39b4fe26d78e317d24f1666c1d730cece3b1cc36c8f3f8e5de1b746"

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
