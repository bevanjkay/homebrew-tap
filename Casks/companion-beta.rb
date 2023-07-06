cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6022-beta-307054a5"
  sha256 arm:   "613af25550feb177416ab841f86441b9aa6fec34def5d28c3020737a73286d0b",
         intel: "a55fff7ace5893f49b7ff0544fc5b7a597227c19c2d5983f1565aaae4f352726"

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
