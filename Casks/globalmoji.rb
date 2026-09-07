cask "globalmoji" do
  version "0.2.0"
  sha256 "1eee9cf79aa7d0e279ae54cd622dbf124e167aef7ce92d73bed7b28738014531"

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
