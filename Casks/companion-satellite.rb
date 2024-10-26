cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.9.3,389-d0d9798"
  sha256 arm:   "6a5261f61a3378d6f9dc44e1474d8f57e6a7653e649a56e9125807fefdfc1762",
         intel: "f996fe5b7fb79a70f2a0933013e6f273bc47fa4d57ae98536a8c44cca5c3c388"

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
