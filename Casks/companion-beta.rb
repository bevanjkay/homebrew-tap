cask "companion-beta" do
  arch arm: "arm64", intel: "x64"
  livecheck_arch = on_arch_conditional arm: "arm", intel: "intel"

  sha256 arm:   "34402c92f3f6a88990e850b91d75a85f9ffd80cfac7b90efaaa57cf91c37853d",
         intel: "ae83c92505f8cfa4faaedefbdf0b11b0a7d9a6febc35f502639863c36d8a49ba"

  on_arm do
    version "5.1.0+9702-main-9cbabd8533"
  end
  on_intel do
    version "5.1.0+9702-main-9cbabd8533"
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
