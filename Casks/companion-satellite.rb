cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.9.2,383-fbb1bf5"
  sha256 arm:   "4aa9eb8a31d120c72527e2250bfa52a94c160abed6313f327561d9afb08bdd15",
         intel: "0cf0baa1afba1d72f8edd27ecb64e73af6f37daaa534d870366bd6003f2dc4b2"

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
