cask "companion@beta" do
  arch arm: "arm64", intel: "x64"

  version "4.0.0+7871-main-1e1f316d"
  sha256 arm:   "4e67c6c2786ba2a35037560e3631071b424314e5dc7cab09f2efe43198f0f008",
         intel: "4749d6d1f70b54e690f4e660ed029f1470d9a1a407f70741f6efe99fbf4c26a9"

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
