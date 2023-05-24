cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5898-beta-1c76b4c0"
  sha256 arm:   "b99f9f1f9837d685bbc47478fe95cab4ec8bd61bed2cc3869b8039e75d5640db",
         intel: "836465a3bbf0af6cf126347546621f0cebf64cd374795c0375cdc557f737947a"

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
