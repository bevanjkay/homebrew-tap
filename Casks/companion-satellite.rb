cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.5.5,244-f2d98b3"
  sha256 arm:   "87c112ed23b83bcc9b3c6f05a5b37cbf78375ea902e53a2140bccff6f90f8767",
         intel: "b317f1aeb3b5a1c23c800eee46ab82d24149ebe3c7712df131d96125ee4fd6d8"

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
