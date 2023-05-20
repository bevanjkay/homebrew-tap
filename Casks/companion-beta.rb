cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5892-beta-92d098a4"
  sha256 arm:   "c1e40ac8aa329b3e8a5d1ab5ea569d4d6097d433260fb1cc367d5abaaca0a216",
         intel: "3fb2b15fe7d624e66a98ada6849d995ff3604e2e6afd5e86341725705bcac04f"

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
