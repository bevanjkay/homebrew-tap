cask "b-hyper" do
  version "3.3.0-canary.1"

  if Hardware::CPU.intel?
    sha256 "5168faa9762977594d386ae17b33e3c00e04a4b036fd319ad28e3d1c0247dad4"
    url "https://github.com/vercel/hyper/releases/download/v#{version}/Hyper-#{version}-mac-x64.zip",
        verified: "github.com/vercel/hyper/"
  else
    sha256 "d5d8265328e489846a2c6bfb24c77ae1538f337132eb9ef5ac4acd6be75eeabc"
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
