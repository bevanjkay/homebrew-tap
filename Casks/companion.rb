cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.2.1+6676-stable-fa981d25"
  sha256 arm:   "3f74cc1e39c758566ef5da675761d9fac4fb2733084b5849d57ff8cbfd79912e",
         intel: "ec911f1ff8f43a7534e50e7a6bd5e93adbc23eff430a6e7d3307847afa437a42"

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
