cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5923-beta-90d7409f"
  sha256 arm:   "febdf48efd92908591ae445036f4d0783b2cbf4aad98d520c42f858529b3003a",
         intel: "1fd0bb900099b240f05f6081d44f7ed9de44de6a7986f2af69cfa4ba9be113da"

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
