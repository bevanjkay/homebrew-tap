cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.0.0-rc2+5989-stable-4d17e724"
  sha256 arm:   "6f4b20244ee7c94c506b5e8524dc90e4920eac17c70555436d4afa68f8a7ead6",
         intel: "e1f690e54be614d251063dd9377d356a588d6922c98bdceb06feba7ccb09d476"

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
