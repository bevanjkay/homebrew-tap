cask "companion-beta" do
  arch arm: "arm64", intel: "x64"
  livecheck_arch = on_arch_conditional arm: "arm", intel: "intel"

  version "5.0.0+9468-main-bc01c3527c"
  sha256 arm:   "7c7feaaa03dfafa088e833fedacaa516606d1f981335c95f2939c768a7e6a812",
         intel: "398b96ac57dd5effd321a0aa56417cca05b01bb9b3343db57748609d19bd9c0f"

  url "https://s4.bitfocus.io/builds/companion/companion-mac-#{arch}-#{version.tr("+", "-")}.dmg"
  name "Bitfocus Companion"
  desc "Streamdeck extension and emulation software"
  homepage "https://bitfocus.io/companion"

  livecheck do
    url "https://api.bitfocus.io/v1/product/companion/packages?branch=beta&limit=150"
    strategy :json do |json|
      json["packages"]&.select { |c| c["target"] == "mac-#{livecheck_arch}" }
                      &.map { |c| c["version"] }
    end
  end

  depends_on macos: :monterey

  # Companion beta does not share preferences with the stable branch, so can be installed side by side
  app "Companion.app", target: "Companion Beta.app"

  zap trash: [
    "~/Library/Application Support/@companion-app",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/test-companion.bitfocus.no.sfl*",
    "~/Library/Application Support/companion",
    "~/Library/Application Support/companion-launcher",
    "~/Library/Preferences/companion-nodejs",
    "~/Library/Preferences/test-companion.bitfocus.no.plist",
  ]
end
