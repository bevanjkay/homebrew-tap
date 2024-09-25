cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.4.1+7323-stable-e32a1052"
  sha256 arm:   "ce7c9d11539c945e7455d5d12e391138a1e6711cb826046a726017066a3123cc",
         intel: "418e74828fe3c7d47eb8742f4ede490d4dec01e3e827e385b6e2c198e5f9b930"

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
