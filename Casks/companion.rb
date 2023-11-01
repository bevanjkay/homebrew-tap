cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.1.2+6243-stable-05c37a10"
  sha256 arm:   "da347ecf5aab1e0de673ca0a659e54652e82fb1090b98fec10c88bff0f1304d0",
         intel: "9572bcb3547a981c912931ad6eb9e263dac05ec2d9e258222fba1e5f193897fc"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=stable&limit=150"
    regex(/companion[._-]mac[._-]x64[._-]v?(.*)\.dmg/i)
    strategy :json do |json|
      version_url = json["packages"].select { |c| c["target"] == "mac-intel" }.map { |c| c["uri"] }.first
      next if version_url.blank?

      version_url.scan(regex).flatten.first
    end
  end

  auto_updates true

  app "Companion.app"
end
