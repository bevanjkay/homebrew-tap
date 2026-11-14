cask "focus-up" do
  version "0.1.4"
  sha256 "60dcb2887caff084f79c4ccddd97dbab729ecae89a5cec5e9a7641a785aeac74"

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
