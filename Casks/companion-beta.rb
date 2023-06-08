cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5930-beta-b9647623"
  sha256 arm:   "d8382d5d061955d15e7e307c23d0e25a73a3b54fb437a39de7bfcb3f2f7a9ba0",
         intel: "673bfad2909ed5f07ee96ac8f4f20c4f4efd1d5b87396e8ce65938c85deb6542"

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
