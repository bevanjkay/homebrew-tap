cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.1.0+6223-stable-1b6dfc49"
  sha256 arm:   "3671ba4a180a217d2499c85edacb7f9edbf8a8df2617541a6972f5d42a4c5106",
         intel: "fe5bc915af58b0174cfb0921aa04b01dbf8303950de8fc4b1c19785303277595"

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
