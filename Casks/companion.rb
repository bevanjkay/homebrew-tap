cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.3.1+7001-stable-ee7c3daa"
  sha256 arm:   "92529228103923ea81226b528e3f2fc18049cbaa43b4e4f5366e72ceaae46d55",
         intel: "28ef0bc37e073ea9d5e3e06b705a6efbac27a2ebfb65aaee83722ec097139e60"

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
