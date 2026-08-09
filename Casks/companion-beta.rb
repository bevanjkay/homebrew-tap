cask "companion-beta" do
  arch arm: "arm64", intel: "x64"
  livecheck_arch = on_arch_conditional arm: "arm", intel: "intel"

  sha256 arm:   "3c6d892e3e352e221ec6a405656d73be6ab38198b4245ed3e74a4a16335f43dc",
         intel: "f2381d8e0f7869278e3d2284c02954d98840e8c2681447553b186a86bdc7e3b3"

  on_arm do
    version "5.1.0+9799-main-90c46d1c2b"
  end
  on_intel do
    version "5.1.0+9799-main-90c46d1c2b"
  end

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
