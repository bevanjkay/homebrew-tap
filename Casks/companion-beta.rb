cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5885-beta-142d1bfa"
  sha256 arm:   "db769c3143adb38b813174cf768644baa413b2c0e02b144a1854bed1f9d1903c",
         intel: "f71de0e3079d7ed30736305cbb1fa241e785d1581711b6beeace9f62bc9c1d60"

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
