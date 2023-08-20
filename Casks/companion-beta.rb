cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.1.0+6120-beta-0218b26d"
  sha256 arm:   "5dbbb9a988e803bc2f5dd0b198ab31bed8776e3b0137ac43c7eda7f3c75e8069",
         intel: "2994f4f90a024cf2c84644c5ec32aefc15366c3edc6f895cbe3a8cba8d28c854"

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

  # Only removes the preference file relevant to the beta version.
  # To remove all files, also run brew uninstall --zap --force companion
  zap trash: "~/Library/Preferences/test-companion.bitfocus.no.plist"
end
