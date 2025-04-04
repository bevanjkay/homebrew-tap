cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "2.0.2,468-b92fa8d"
  sha256 arm:   "037274f8c52b83e32d016e9348b7b9dfd813de810c7f3337904ee95498acf0f4",
         intel: "06b42338480d994e4cca8ed0d8aac026f68ac467aae97f2ab33e7617e2455d0f"

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
