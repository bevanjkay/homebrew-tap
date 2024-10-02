cask "bettertouchtool@3" do
  version "3.741,1883"
  sha256 "dfa416445ce490d47e59764ed506896349060d2aaaae9aba6a0924cf0152bf37"

  url "https://folivora.ai/releases/btt#{version.csv.first}-#{version.csv.second}.zip"
  name "BetterTouchTool"
  desc "Tool to customize input devices and automate computer systems"
  homepage "https://folivora.ai/"

  livecheck do
    skip "Pinned version"
  end

  conflicts_with cask: "bettertouchtool"

  app "BetterTouchTool.app"

  zap trash: [
    "~/Library/Application Support/BetterTouchTool",
    "~/Library/Preferences/com.hegenberg.BetterTouchTool.plist",
  ]
end
