cask "focus-up" do
  version "0.1.1"
  sha256 "0d9ef98f6b5d92e4da9aa14bcdc072891c061a147874ca86b0ddf84fd07a9724"

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
