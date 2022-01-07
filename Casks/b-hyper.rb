cask "b-hyper" do
  version "3.1.5"

  if Hardware::CPU.intel?
    sha256 "3d87e611190678a4b7240c6f4e373f8dffe6b838f0fb235b33be134931e87da0"
    url "https://github.com/vercel/hyper/releases/download/v#{version}/Hyper-#{version}-mac-x64.zip",
        verified: "github.com/vercel/hyper/"
  else
    sha256 "ab7dd0833e87311fc53fe32390377cbbf99387e3668b18c77082aa58da1a89fd"
    url "https://github.com/vercel/hyper/releases/download/v#{version}/Hyper-#{version}-mac-arm64.zip",
        verified: "github.com/vercel/hyper/"
  end
  name "Hyper"
  desc "Terminal built on web technologies"
  homepage "https://hyper.is/"

  livecheck do
    url "https://github.com/vercel/hyper/releases"
    strategy :page_match
    regex(/hyper[._-](\d+(?:\.\d+)*.+)[._-]mac[._-]x64\.zip/i)
  end

  auto_updates true
  conflicts_with cask: ["homebrew/cask-versions/hyper-canary", "hyper"]

  app "Hyper.app"
  binary "#{appdir}/Hyper.app/Contents/Resources/bin/hyper"

  zap trash: [
    "~/.hyper.js",
    "~/.hyper_plugins",
    "~/Library/Application Support/Hyper",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/co.zeit.hyper.sfl*",
    "~/Library/Caches/co.zeit.hyper",
    "~/Library/Caches/co.zeit.hyper.ShipIt",
    "~/Library/Cookies/co.zeit.hyper.binarycookies",
    "~/Library/Logs/Hyper",
    "~/Library/Preferences/ByHost/co.zeit.hyper.ShipIt.*.plist",
    "~/Library/Preferences/co.zeit.hyper.plist",
    "~/Library/Preferences/co.zeit.hyper.helper.plist",
    "~/Library/Saved Application State/co.zeit.hyper.savedState",
  ]
end
