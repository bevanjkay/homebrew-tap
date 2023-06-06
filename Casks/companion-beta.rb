cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5926-beta-c723ce13"
  sha256 arm:   "6a3901be3d02933cf1e8e4edfc1d3b615964e6aff4638e4240272218215e9b0f",
         intel: "1c3646f609899b5618c453cbd16627f75c7441572cbc2a9f01f05c857374b5d4"

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
