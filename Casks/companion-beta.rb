cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6031-beta-61964dae"
  sha256 arm:   "04bd5e8e7cf33fcf894482afda13a86a0cea173f4e4b063d9279dbd5e001ab68",
         intel: "6dd329fb2d52d50a2106481b177785dbf79e5dff05d2aa0d8d2b2628626ba098"

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
