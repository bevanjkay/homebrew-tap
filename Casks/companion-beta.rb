cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.1.0+6085-beta-a40831e1"
  sha256 arm:   "6186ae1e4455683f4d4f6a11a13fd3237163da40c38269f77d9bc6db5a9b0e7e",
         intel: "ac296a38f01a8307f12a0d06fef3663bfa843f0a931344c0141e8314b200fe91"

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
