cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.7.0,305-7c0c773"
  sha256 arm:   "ed0077283536f7077bc3ed20b47bdc8f48011be5ca1849ad129d8befb3d13037",
         intel: "4d7444213fdd79153dc2afba1bbe5e47707fc9cf19a021d08c13184aa87be173"

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
