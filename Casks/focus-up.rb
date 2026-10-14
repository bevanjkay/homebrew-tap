cask "focus-up" do
  version "0.1.2"
  sha256 "b12a32410ff2dd1debb76eac29efdb5488ab0b5ef86959979d57845573038f72"

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
