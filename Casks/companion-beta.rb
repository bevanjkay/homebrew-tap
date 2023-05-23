cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5896-beta-970ebfb2"
  sha256 arm:   "f3c8423584a354b2f12a738f9217636a49c534c160b1d3a131fa6cf328b1471d",
         intel: "2307422e3995a4a3ab27bbc10ec88db68f55631507fcb602f41fbd7422eec378"

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
