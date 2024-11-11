cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.10.0,399-8959d07"
  sha256 arm:   "0a9754533d2cf965167dc1a2d69e9566bfc40b88f4977a8d12da46a16b2f70ad",
         intel: "fd03187286df1b6ce9d3b5099d9e7aabc2d65c404f995eb61969870f9f5f3f5a"

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
