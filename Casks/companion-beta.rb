cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5925-beta-8de75aea"
  sha256 arm:   "d192f5544b511856d3b81b506a51ae1c6d24587f4952701cca25bb1a7156abb4",
         intel: "a15ff3d05df465378ff1ff972f5df63f4d1513d221761b772016b121a1fcf283"

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
