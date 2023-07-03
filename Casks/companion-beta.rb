cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6008-beta-e9d67880"
  sha256 arm:   "423045137886a953555cb699697bdda64d82e577c473e3e0d72d31f6d67ae787",
         intel: "9e5a14eb0bae91a0f69731373ce007d83284cf3f127c6c736dc554e4cff4641c"

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
