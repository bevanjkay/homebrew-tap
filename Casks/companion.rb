cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0+6049-stable-126f27e8"
  sha256 arm:   "7e356c2c6181e673e75967c30375492ad8891d6fd44071a3b41ad5335569b219",
         intel: "5bf98e93e4c2adb5e107565df8cd8dc2ecdf45fd15e9f6f8640e1bd83fc3c6f7"

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
