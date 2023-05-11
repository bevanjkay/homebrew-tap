cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5866-beta-f0507bc6"
  sha256 arm:   "e4ce7f5091a0f123ba90a1eef23ff0455e52de7aa71205ddc91ac1637dce875a",
         intel: "42f1fe1c765fd668ebe364d805f442bf1607318638db879030f0514284fffd4e"

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
end
