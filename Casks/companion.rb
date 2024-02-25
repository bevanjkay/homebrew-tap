cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.2.2+6688-stable-7417d2a0"
  sha256 arm:   "239e39619a2b093eabef9f35135399eee862aa8fb97a85db2272f38099f22859",
         intel: "e2e6707e9a83c8655dcc8a27bedce809a534f1d96dadc83b0b00c517108f6b78"

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
