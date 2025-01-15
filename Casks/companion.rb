cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.4.4+7361-stable-03160d5b"
  sha256 arm:   "9de99d9c08a4151f12fb78617243e08a9585a028f82bb0a67b5d676e410f9773",
         intel: "d72f7d8eae16119cdb0fa65fad447fdc9a9c63f7acd802495d8ff058dbb0d22f"

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
