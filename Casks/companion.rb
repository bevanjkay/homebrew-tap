cask "companion" do
  arch arm: "arm64", intel: "x64"

  version "3.4.0+7304-stable-01df0f17"
  sha256 arm:   "f4ee2640d48b70b0bce717a759147e4d569deef2284290c54d8710bff2838d1e",
         intel: "b570df673f07ec5cbf501360c3df14cb5448e266d428de4d27b763caa590f686"

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
