cask "globalmoji" do
  version "0.1.0-alpha.2"
  sha256 "fba3a3625ba36523c16fb16b1703a743cef7cb29fc44e23fdf838f3bede29137"

  url "https://github.com/bevanjkay/globalmoji/releases/download/v#{version}/Globalmoji-#{version}.dmg"
  name "Globalmoji"
  desc "Emoji, GIF and ASCII picker triggered by typing a colon in any app"
  homepage "https://github.com/bevanjkay/globalmoji"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: :tahoe

  app "Globalmoji.app"

  zap trash: [
    "~/Library/Application Support/Globalmoji",
    "~/Library/Preferences/me.bevankay.globalmoji.plist",
  ]
end
