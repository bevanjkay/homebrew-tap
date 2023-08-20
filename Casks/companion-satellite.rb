cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.5.0,223-38e0b96"
  sha256 arm:   "8c3cacb885b284d10e3b34088526ca4ae02a582bfbabaddf283830cf7c8b8041",
         intel: "73316c02a211cf7ba1d8115f5267828b16f30c723b5ef7d4e62daaeac149c668"

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
