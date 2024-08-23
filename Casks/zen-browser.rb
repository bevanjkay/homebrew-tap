cask "zen-browser" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0-a.28"
  sha256 arm:   "d174b63a5feedb065cf9d53676a8303fd6e3100ddf1a9501e10d32fa7a4799f9",
         intel: "c5f633c38c45e5712f39039abee799de12dffd04a3d3e52805c7ed1f0fb551c0"

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
