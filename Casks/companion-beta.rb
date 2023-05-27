cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5910-beta-3a06af5b"
  sha256 arm:   "ff5c9bd9855ac50ab95f78c1df74942db0b222d7397c1f7c4acc0e41d12fc9d8",
         intel: "b2eaf6021ceaf83967100e25d4c0f423c6fc182fb6cb162cece8a9d63f0552af"

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
