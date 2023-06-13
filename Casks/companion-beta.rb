cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5939-beta-9e474498"
  sha256 arm:   "c09d8c504882d4175d1b353d83d0bf25e7b482078e8ce89443e73f25bee6813a",
         intel: "311ae6a102d6664de8b60f7d9599cac895e3ac039264f92b4f4ea9d22d7df888"

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
