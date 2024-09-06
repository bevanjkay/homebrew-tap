cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.9.1,373-5876f1e"
  sha256 arm:   "0ed190622d1fa45f84500c488c284f51889e9d1333e6b2a87305d61f56dcd368",
         intel: "4c3867183aa13547a45008593c6fa9f69c450098f93bbcf11f2955b2ad4afa35"

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
