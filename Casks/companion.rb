cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.1.1+6229-stable-4593dd7f"
  sha256 arm:   "bf9db3585c8e906d8d57d82a15c089198e7642e2201f5ad64537f9897d4a201a",
         intel: "41e62321068e9b3b7ac49e962de0ccd07191ec93fccd5bb1a119b5eab56c863f"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=stable&limit=150"
    regex(/companion[._-]mac[._-]x64[._-]v?(.*)\.dmg/i)
    strategy :json do |json|
      version_url = json["packages"].select { |c| c["target"] == "mac-intel" }.map { |c| c["uri"] }.first
      next if version_url.blank?

      version_url.scan(regex).flatten.first
    end
  end

  auto_updates true

  app "Companion.app"
end
