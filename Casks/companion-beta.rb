cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6028-beta-142cbff9"
  sha256 arm:   "33315bda0395f5477f500157f4615a122d85acf08d2adddee3e564b7cea94cc7",
         intel: "6e9f2c90687955de9f2b478711f220b2b2a70cf51befb037e78b88d24c30919b"

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
