cask "b-companion" do
  version "1.0.1"
  sha256 "bbf4e8c80fdb89a57590eb5ee39f02721bcf58f79110ebd9f8846b433419d373"

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
