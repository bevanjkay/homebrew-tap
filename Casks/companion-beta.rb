cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.3.0+6921-main-2d231c0a"
  sha256 arm:   "999fe632a97a1715b56fe73f91d85d8e5846d577092154c2899de3406dace5f8",
         intel: "1f66cb0a3d8b510c5e894f32d69629ed66493ec3a5dc59e0806bd6d35bc01ebd"

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
