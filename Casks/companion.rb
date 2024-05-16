cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.3.0+6991-stable-b27baf94"
  sha256 arm:   "f1d50d654120cf5755a6e7112e8adabce2a1c07fdb05edfa6cf45d86082fbfbc",
         intel: "f874d9002f1474d244042076c79db7cd2280bf4064f23ddcd5cb2b0283857552"

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
