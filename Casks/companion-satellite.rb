cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.6.1,270-ed43061"
  sha256 arm:   "cfc4f6f6656c5a5eed0452d90ced8d8e6189d30d2e0f92f5f5aea369824ca4fc",
         intel: "1f0b48148141485c144d883763e1d960079a46a3a1d7b2e8894abf26c5fac82f"

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
