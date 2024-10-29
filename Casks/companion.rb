cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.4.3+7347-stable-23764ac2"
  sha256 arm:   "3f2bfcbb8b2205a0c9c797334ac3767329cdaef0545e9c64ee77e760e9a42e0b",
         intel: "3faa168e5bbd7893578fc7744fe11398e9e45adc086f438b69776dca79ba9573"

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
