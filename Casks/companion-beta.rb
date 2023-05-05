cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5839-beta-1477f007"
  sha256 arm:   "f46791f80215fd2afc11d4d66d70fec0a79a07ba5e2be3ef5e4682fb9978dcf2",
         intel: "d5909c43036c8a56df906f6a192c74ea6574435166cc6a7133d7ca29eeee74ca"

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
end
