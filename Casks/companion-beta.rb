cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.2.0+6616-beta-742dd271"
  sha256 arm:   "6b153b1adb5ef08640c2e44ddb57a0d8bfc79010a068a962bfea75d4dd411988",
         intel: "0ed81860b40733582f8bd4f2f03ad107c0ab7c0fcba8c6e3b09ab12a50dca833"

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
