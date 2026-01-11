cask "companion@experimental" do
  arch arm: "arm64", intel: "x64"

  version "4.99.0+8987-develop-81413757ff"
  sha256 arm:   "a25a7a9a21690bcc0067207663fac3f3aa6b9bd74da34464c1f59e805e12360c",
         intel: "2ead79bd09f60af41b9302a42610f36364b3c741a3e222f643bb5a956ca7ac5e"

  url "https://s4.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version}.dmg"
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
  depends_on macos: ">= :monterey"

  app "Companion.app", target: "Companion Experimental.app"

  # No zap stanza required
  # Shares settings with companion-beta - so don't remove
  # To forcibly clean up, run brew uninstall --cask --force --zap companion-beta
end
