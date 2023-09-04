cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.5.1,228-6f036a0"
  sha256 arm:   "7bcf6140fa4a16986c05efa7ae4cd0500b3f4647ebd375dbfe70fde423d151ee",
         intel: "004ce03e5912ba4b83988fa8821b38d29284a157a4913a40a63190d1ccb64970"

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
