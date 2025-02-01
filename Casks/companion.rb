cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.5.0+7740-stable-89a7f8ac"
  sha256 arm:   "8da14472906396373aed877d448549c25728d1efaa348b2e92dc8a59bf9905e5",
         intel: "52c13d4441f6db9ed2dd9c63c23b3858da1af0dd1e268d5437ca299a1e2f5a26"

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
