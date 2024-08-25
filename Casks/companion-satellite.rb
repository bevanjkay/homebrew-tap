cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.9.0,367-0ffdaf8"
  sha256 arm:   "ef233ca50aec02baa9ee267797f5097a898d8596a9fe10e1daab154c1dd788f5",
         intel: "099617f0940ec2be22d47bb4773ad02ffe65c2689ff0357124ab7d39cfd34dd3"

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
