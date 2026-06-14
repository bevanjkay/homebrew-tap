cask "companion-beta" do
  arch arm: "arm64", intel: "x64"
  livecheck_arch = on_arch_conditional arm: "arm", intel: "intel"

  version "5.0.0+9502-main-fe7a09cf5b"
  sha256 arm:   "20338b59ac582c61d372516c5b3114dccd097bb03ec8724666f796777b5473f7",
         intel: "1c61fc725ea5985af22a1685069ff375cbf6d69058aee01eaafb71a70f6f62cc"

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
