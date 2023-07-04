cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6013-beta-94fab240"
  sha256 arm:   "b5993c5c7407003d4b7b9e769cdcf7ba28a0e4363d484eab90df452e30a1ccbc",
         intel: "d48adbe9eff6c17ffa89e44351b9daf739bb600c88e7e0d81e62d87432c4969c"

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
