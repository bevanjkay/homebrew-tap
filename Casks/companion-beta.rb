cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5978-beta-4cc76774"
  sha256 arm:   "a872704a8ae39ca19c24dd3abbb176c122eeaee88dae45e8d8f1ab66770d9fc5",
         intel: "b15791411d023925bcc1849aada469d5c44cf0786004e7e7fb2f16ed64e4e56d"

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
