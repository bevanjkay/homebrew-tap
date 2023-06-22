cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5988-beta-b2b13bf0"
  sha256 arm:   "d5fe9b6b0bf4998f96f7152520739a177444b6d50cb20733b7d7d8bf93b0d57b",
         intel: "0639ff4950ef16504fb7ec3ac14faceb7d73bd2004761d8d00308870265c0d86"

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
