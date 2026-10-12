cask "focus-up" do
  version "0.1.0"
  sha256 "dc0d8d807f740fa51801393c4c673fc85ac3a58edc20171f2f33b42796490226"

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
