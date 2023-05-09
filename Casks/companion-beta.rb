cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5863-beta-d9830ca2"
  sha256 arm:   "2dacf8c41926904e2c4f9413465141833eb5918c657ae284e952fb820de165e6",
         intel: "cc3f98b2751520a0b0ba9a433df5f632ba24ffe928906d6d459ca13d0bef8472"

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
end
