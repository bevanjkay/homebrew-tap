cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "2.4.2+4911-v2-4.2-fcb5a863"
  sha256 arm:   "c91793b0a3fb430358b010ed275f6250d537f7dbb162058aa3600142ca98906d",
         intel: "87b66469c9533ab9be38e454037b6eb83f39621e388dbb9c87909257c4f07f70"

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
