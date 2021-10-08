cask "b-companion" do
  version "1.0.2"
  sha256 "3e77df6894fa4c56ca153465dd178bc9e5761eb0b72f19d4af601abeb2edcf21"

  url "https://github.com/bevanjkay/companion/releases/download/#{version}/companion-mac-x64-#{version}.dmg"
  name "b-companion"
  desc "Companion app for Gateway Church Geelong"
  homepage "https://github.com/bevanjkay/companion/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Companion.app"

  zap trash: [
    "~/Library/Application Support/companion",
    "~/Library/Logs/Companion",
    "~/Library/Preferences/companion.bitfocus.no.helper.plist",
    "~/Library/Preferences/companion.bitfocus.no.plist",
  ]
end
