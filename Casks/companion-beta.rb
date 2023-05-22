cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5895-beta-26db36a0"
  sha256 arm:   "5788394957b1430b4bb78915b2e54211fef911c8eb150544cc0d17a675830a0c",
         intel: "63babf328704f3e678ac70ebc5cdc68ad003de87c6471ca39126ce6e5d17362b"

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
