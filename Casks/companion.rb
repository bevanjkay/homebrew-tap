cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.5.2+7764-stable-fe36af46"
  sha256 arm:   "802392d1eb8d7a63e8f9b60d74501e18fad077e326919072c3af4a2b76059af3",
         intel: "564c0eb2b0e6a59e065c2a4073d37a1f3cf398e3ef147ae5e8c87cde4c86d21b"

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
