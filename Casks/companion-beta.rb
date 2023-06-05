cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5924-beta-f11f0c02"
  sha256 arm:   "0734ec2977b41c891801683100e5af30e7316a62d0d64673f52168d5a0209648",
         intel: "47290bdded880d5caae959d561d585a84f3ed52f556ae97e7c3936ce90289e66"

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
