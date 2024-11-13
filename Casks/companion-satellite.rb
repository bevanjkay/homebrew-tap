cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.10.1,401-24ee487"
  sha256 arm:   "299a3b56856943be35dde45bf190d6c6ba7147fb4908ca4e7e6a828478fb3861",
         intel: "5f8f62b8a1a7fec6d9dffc515b70e066fea9f0deea11fcd4670bc4a6ceb26191"

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
