cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5887-beta-381046f0"
  sha256 arm:   "d89274aebda0e985e04887f13435a8f5f3c5fe5da942ff81f8352d7597e2354b",
         intel: "f5235a9ef2700aa89b90fe19b07c32d9972fcaa52f047672348b1ba0a5467ff0"

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
