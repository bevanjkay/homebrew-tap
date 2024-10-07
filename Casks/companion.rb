cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.4.2+7335-stable-fc3fe2f0"
  sha256 arm:   "b7136d08c6231fd57b2d136ab285bbfc38b72a479093fa5472ec15cd99697507",
         intel: "6db05fd8cd8e00aee7c22b4b26e4352a57ec32ae36d1f3fc58faf90210fb0002"

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
