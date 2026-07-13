cask "sharedown" do
  arch arm: "-arm64"

  version "5.3.6"
  sha256 arm:   "13481b1ac40a65555367d2cba60e0021b4a1326c698ac5238a1cabd2c0176472",
         intel: "253945c40c64321806ac5fcfeaa210b36c1336af3353d6cca75da99becc1fc0f"

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

  depends_on macos: :monterey

  app "sharedown.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/sharedown.app"
  end

  zap trash: [
    "~/Library/Application Support/Sharedown",
    "~/Library/Preferences/com.electron.sharedown.plist",
  ]
end
