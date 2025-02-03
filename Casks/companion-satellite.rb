cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "2.0.1,459-b31b4b0"
  sha256 arm:   "45068afbc7eb956e6fdc399d7f49b4d3f9383a96fc2eb03afef74b08cd307a86",
         intel: "72b27a96597a8750aa4bc6867ee353dd68b1720cc1176441bfcca973b69e2c70"

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
