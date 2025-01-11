cask "companion-satellite" do
  arch arm: "arm64", intel: "x64"

  version "1.10.2,408-6fd7beb"
  sha256 arm:   "67bca031e985c7912376c5dbfb52e2fc620471a2ef17209bfd2a5f7aa4e64832",
         intel: "16a4c5a9fff1a55daf239474b1b5fe55da5bed6b005990c6f9bb2ac97d6a486d"

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
