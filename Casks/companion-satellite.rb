cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.6.0,266-d96b183"
  sha256 arm:   "70af37a40e3d15174b1986ae9f1f9ad7096483a15692988d87aff45ab41a639f",
         intel: "ec6f934b673c2a33374979b57da9d5a4d8912ad47dd93c5a97daff1c0d9c73cf"

  url "https://s3.bitfocus.io/builds/companion-satellite/companion-satellite-#{arch}-#{version.csv.second}.dmg"
  name "Bitfocus Satellite"
  desc "Satellite connection client for Bitfocus Companion"
  homepage "https://bitfocus.io/companion-satellite"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion-satellite/packages?branch=stable&limit=150"
    regex(/companion[._-]satellite[._-]x64[._-]v?(.*)\.dmg/i)
    strategy :json do |json|
      matched_items = json["packages"].select { |c| c["target"] == "mac-intel" }
      next if matched_items.blank?

      matched_items.map { |m| "#{m["version"].tr("v", "")},#{m["uri"].scan(regex).flatten.first}" }
    end
  end

  auto_updates true

  app "Companion Satellite.app"
end
