cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5998-beta-ac1b6efc"
  sha256 arm:   "c6c76fcbd8dd3d602e4455348b9f066796449982053a241045a5db118b8711ce",
         intel: "88c0076844f6499cab6ad3e88f4ad0c9031b9b542731301b3be13bc11a0ae41d"

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
