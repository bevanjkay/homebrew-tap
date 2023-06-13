cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5940-beta-27096892"
  sha256 arm:   "51267ebac01380172d754bfad431810887d00c971697bf682113ba3471d5f68b",
         intel: "98fac77c947b1fb4d92ff9ff34dde56e52cdaca0d80daf1061b3a30f2e0baf8f"

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
