cask "b-companion" do
  version "1.0.0"
  sha256 "527ad2eca1d465e23408e729c8dd2e1d63b3a43a237e7906d62a13dd99710321"

  url "https://github.com/bevanjkay/companion/releases/download/#{version}/companion-mac-x64-#{version}.dmg"
  name "b-companion"
  desc "Companion app for Gateway Church Geelong"
  homepage "https://github.com/bevanjkay/companion/"

  app "Companion.app"

  zap trash: [
    "~/Library/Application Support/companion",
    "~/Library/Logs/Companion",
    "~/Library/Preferences/companion.bitfocus.no.helper.plist",
    "~/Library/Preferences/companion.bitfocus.no.plist",
  ]
end
