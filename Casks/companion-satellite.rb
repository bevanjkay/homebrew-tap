cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.5.6,258-fbd228d"
  sha256 arm:   "7af7eebb8fab63b98bf27c28c955f0a74c0f4c8a3dd32e60cd79e91c3ff05d53",
         intel: "6480bac613b88d5b0fc80d16db0f5f35908abb7cbca008cd5631bb8e363c3e72"

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
