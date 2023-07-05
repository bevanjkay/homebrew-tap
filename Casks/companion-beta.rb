cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6017-beta-ad70dd70"
  sha256 arm:   "adb36ab6abb74a3462d085a655a6abafaeb64fa12e5a781ac1fc3a47683c5de3",
         intel: "a67c54bf56ffcc862e7765d91521a269ed0659282580d6346271b8d00360c778"

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
