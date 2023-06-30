cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6003-beta-dac3c043"
  sha256 arm:   "34d7ed8ba42b6dc9c00bdfa6b5717f8ddc5371b6b90cea9d0fc50634e8528506",
         intel: "2a85bba16a936d429a27f54d2440b7227b362564a4c61e27be9d84dca0c73d32"

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
