cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5897-beta-816bafa7"
  sha256 arm:   "c26f3b4e4ffa5ba57bdd81419f4955ebc324748d5b813995d34662152f2a150f",
         intel: "77c6169c330378a168bd656ab18850733e3cd333cb6759a1f623edeeb45ca0e4"

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
