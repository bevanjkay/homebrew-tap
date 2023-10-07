cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.5.2,239-ea77fc2"
  sha256 arm:   "9e1f2e07519b0cc445e5b109f19cdd9a1ad84f49976f8b466a156e40f4f04119",
         intel: "ac5feba9de45f554cf64b6c1b002690757f90fbd60a922814389a46fea91420f"

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
