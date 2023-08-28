cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.0.1+6068-stable-a05a9c89"
  sha256 arm:   "052b6e7f06909c9b515d14f9f073da646f36174d3acb00ebb893140081f12425",
         intel: "b42b8555437bb2b2ba66669243282f6ab108144213ba0eebcc1da297881691bc"

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
