cask "nps-browser" do
  version "1.4.6"
  sha256 "d4f12f178e1147070fac36a288e53a53a9ae47e89530041e54e559b20efda620"

  url "https://github.com/JK3Y/NPS-Browser-macOS/releases/download/v#{version}/NPSBrowser.dmg"
  name "NPS Browser"
  desc "Sony ROM Download Browser"
  homepage "https://github.com/JK3Y/NPS-Browser-macOS"

  app "NPS Browser.app"

  zap trash: [
    "~/Library/Application Support/JK3Y.NPS-Browser",
    "~/Library/Caches/JK3Y.NPS-Browser",
    "~/Library/Caches/NPS Browser",
    "~/Library/HTTPStorages/JK3Y.NPS-Browser",
    "~/Library/HTTPStorages/JK3Y.NPS-Browser.binarycookies",
    "~/Library/Preferences/JK3Y.NPS-Browser.plist",
    "~/Library/Saved Application State/JK3Y.NPS-Browser.savedState",
  ]
end
