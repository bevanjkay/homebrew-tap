cask "zen-browser" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0-a.31"
  sha256 arm:   "230446f4a235a29380d820c832a4e324bd9afb5009cccb6f5b3bed586fff3730",
         intel: "a3d56a2b254824b9b7c8064015829c46fed0851843f7d67e52209d1551333d5e"

  url "https://github.com/zen-browser/desktop/releases/download/#{version}/zen.macos-#{arch}.dmg",
      verified: "github.com/zen-browser/desktop/"
  name "Zen Browser"
  desc "Web browser"
  homepage "https://www.zen-browser.app/"

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Zen Browser.app"

  zap trash: [
    "~/Library/Application Support/zen",
    "~/Library/Caches/zen",
    "~/Library/Preferences/org.mozilla.com.zen.browser.plist",
    "~/Library/Saved Application State/org.mozilla.com.zen.browser.savedState",
  ]
end
