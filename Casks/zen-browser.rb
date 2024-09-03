cask "zen-browser" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0-a.35"
  sha256 arm:   "0cfd649710062d1bb9dba75e8041e88e9c7a0ad73b3510e3d977ff30e2ceb1fd",
         intel: "66ba923dc43e070ea940aee8563af50486f275c28232c6c8a05973d309abd41b"

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
