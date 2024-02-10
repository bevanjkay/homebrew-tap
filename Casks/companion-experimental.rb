cask "companion-experimental" do
  arch arm: "arm64", intel: "x64"

  version "3.99.0+6731-develop-1af49291"
  sha256 arm:   "df1d5dcdd1ab6c0020fbb1cbe58180334b4619fbdcfbd2872f46847e4e9d3625",
         intel: "688a238c8267539576247c2553e271f0ab19ed5b995cc8d462db629ae1e3f5eb"

  url "https://s3.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=experimental&limit=150"
    strategy :json do |json|
      json["packages"].select { |c| c["target"] == "mac-intel" }.map { |c| c["version"] }
    end
  end

  auto_updates true

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
