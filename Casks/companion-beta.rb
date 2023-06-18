cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5959-beta-10401b0c"
  sha256 arm:   "427939951b5879149ae87b2c2d955aa755830789f07d3443fd404c42c7786896",
         intel: "e3c8e813a8968eefa829efa6536d9dee800bb139a698d3575c052359c8cf3bd4"

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
