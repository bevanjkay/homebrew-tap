cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.3.1+7000-stable-bf9ef50e"
  sha256 arm:   "9b42137bdc15a4a4519111177ef7c8d6856bc11d886cb99067067e3f046e0210",
         intel: "6182b0238192aa3b1c2ed4ea41878be2442282a3cd39715a23d06bc118e4b821"

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
