cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0-rc1+5909-v3-0.0-rc1-725c3583"
  sha256 arm:   "bdff8582c0a3a64d7f48e7148243f69833fff664e87d19587228e08f02af2494",
         intel: "1d05adb75d48522cd4bb283bd14ba4f2273ab4de2f931da307de19b7df3b9824"

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
