cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "2.0.0,454-06f091b"
  sha256 arm:   "88222da458560a1eff320c824c27367d192217bae6479ec41b14dee51244e11e",
         intel: "4d2602eb35d99e18e5ef18134e21acb0ad7ac4f5c397f38ba8eb7156b8c92fe9"

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
