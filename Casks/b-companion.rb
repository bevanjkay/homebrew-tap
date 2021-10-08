cask "b-companion" do
  version "1.0.2"
  sha256 "6158530a489979b42b59ff139f7c49fdfcde42eb8e3360acb7ff0cd11890a222"

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
