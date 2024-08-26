cask "zen-browser" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0-a.30"
  sha256 arm:   "75642d7239dcf142304ca96f0acb28d6dbc9ab9dcf183d9ffb7913c344e15043",
         intel: "d78b7b5284d5b1d7c1819e17659d4ba8af5498b23a639433a20d8d7daf2338e2"

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
