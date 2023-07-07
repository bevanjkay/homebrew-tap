cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6025-beta-8499d4ad"
  sha256 arm:   "f5620a9db74381ad9dcf2d00340ffe87e79249ee9242d7a15a951c800e9a055f",
         intel: "521f03f460be113ad15264e0405d182301571b6734c00d35768db28b98a3d21f"

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
