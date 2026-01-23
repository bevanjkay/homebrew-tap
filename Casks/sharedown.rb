cask "sharedown" do
  arch arm: "-arm64"

  version "5.3.6"
  sha256 arm:   "1418cf8106ade2ba7843add57fe3223f92864949da0f04e7adcdf95547c29ccf",
         intel: "2248d955046f53676e1ad0a4035305bf4e4ec67fdb918ab6d7c925c4574584e4"

  url "https://github.com/kylon/Sharedown/releases/download/rolling/sharedown-#{version}#{arch}-mac.7z"
  name "Sharedown"
  desc "Electron application to download Sharepoint videos"
  homepage "https://github.com/kylon/Sharedown"

  livecheck do
    url :url
    regex(/sharedown[._-]v?(\d+(?:\.\d+)+)[._-]mac\.7z/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        release["assets"]&.map do |asset|
          match = asset["name"]&.match(regex)
          next if match.blank?

          match[1]
        end
      end.flatten
    end
  end

  depends_on macos: ">= :monterey"

  app "sharedown.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/sharedown.app"
  end

  zap trash: [
    "~/Library/Application Support/Sharedown",
    "~/Library/Preferences/com.electron.sharedown.plist",
  ]
end
