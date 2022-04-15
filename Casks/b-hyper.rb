cask "b-hyper" do
  version "3.3.0-canary.2"

  if Hardware::CPU.intel?
    sha256 "1743ca816edab631d472a28b5ddcac872d45684c8bb82c5c153eb2fb2ab30b64"
    url "https://github.com/vercel/hyper/releases/download/v#{version}/Hyper-#{version}-mac-x64.zip",
        verified: "github.com/vercel/hyper/"
  else
    sha256 "03642fc6e1a84164657297eecadb9fb3858d07c5d66401109601eb36fc27112a"
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
