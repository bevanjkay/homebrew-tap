cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5996-beta-c903b9cf"
  sha256 arm:   "2896fb046e124e7ebe60891193d20163b5094076edd8334a943ac32b61ae2a0b",
         intel: "0a34df0fd2980199527e29400aa24a9eb9adc323ea432fbae477f4510643495e"

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
