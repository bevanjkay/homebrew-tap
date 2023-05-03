cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.4.1,1-beaeb16"
  sha256 arm:   "638244507d9b90831ccd97f27d53b12baf01aa278697181b9b58877ac52ecaa7",
         intel: "f2fd30925b11e7464b9f125875dfbec59ce1b61a4e00d04157f9d70e41079789"

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
