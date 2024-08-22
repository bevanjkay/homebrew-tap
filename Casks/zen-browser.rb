cask "zen-browser" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0-a.27"
  sha256 arm:   "6fd2a7e915bf79a9d92b6c27f88d5d9a6a5da443e08bbf0b9fbcaeab2e414838",
         intel: "ae8e00c0b35f5c3a38e7bf801a74151692fc51b4b4f5d5cb080b36c4d71429da"

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
