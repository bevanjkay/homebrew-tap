cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.2.0+6663-stable-b83f412f"
  sha256 arm:   "ff522e7d901bfec3f5808640a87bb419fd8326d1d76568839dbaab9db23cfa10",
         intel: "448cfb06d2d700e9ea4b304ba27eb595657c3eb79095fc0ac6e1c947f0e3ad92"

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
