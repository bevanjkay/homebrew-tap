cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.5.1+7754-stable-ce49bb18"
  sha256 arm:   "9fa5a27e6a02fafb14abe635924bc404f29c1c0c6bd21408f713bca1e36516c5",
         intel: "e21c40745b74fbfb4b35e5bbc76780aab185bb50434b67cb0ac882242140e31c"

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
