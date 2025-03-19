cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.5.3+7770-stable-df70e20b"
  sha256 arm:   "980a6976b217865cda8f47ccc2c5f1f31c6b1b4a94475c8a8b953ccde8a731ec",
         intel: "3abf3604c804a3378e10d9064f73c78395c412bdb6f52d7c9bb44ed2b23d2288"

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
