cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6014-beta-c62d68b4"
  sha256 arm:   "2385774623b9a98b969f7139aed1af17474923b2faf60956354854d5ef23dac7",
         intel: "45fea901be235c6785efb3ab3e044857f9641a81389b2b1947eaa4a18837fcd9"

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
