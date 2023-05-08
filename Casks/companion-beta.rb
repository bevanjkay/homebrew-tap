cask "companion-beta" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+5850-beta-fe98f2a3"
  sha256 arm:   "47465b3cc74caa748d44bd63ddbe713d8cdfcf7b52c38900984b34a2cc945bda",
         intel: "ddc4e1e79d4ecc723188e2864d3d59467319051822c14480d65427cb64b8b235"

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
