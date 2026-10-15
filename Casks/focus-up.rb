cask "focus-up" do
  version "0.1.3"
  sha256 "69f0f6b3a34342f1af0724af36dcd5724a47b8f2c65b2391ffee1e75000bf605"

  url "https://github.com/bevanjkay/focus-up/releases/download/v#{version}/Focus-Up-#{version}.dmg"
  name "Focus Up"
  desc "Keeps one app in focus by blurring or hiding everything else"
  homepage "https://bevanjkay.github.io/focus-up/"

  auto_updates true
  depends_on macos: :golden_gate

  app "Focus Up.app"

  uninstall quit: "me.bevankay.FocusUp"

  zap trash: [
    "~/Library/Caches/me.bevankay.FocusUp",
    "~/Library/HTTPStorages/me.bevankay.FocusUp",
    "~/Library/Preferences/me.bevankay.FocusUp.plist",
  ]
end
