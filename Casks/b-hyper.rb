cask "b-hyper" do
  version "3.4.0-canary.1"

  if Hardware::CPU.intel?
    sha256 "e1ca5dd3685613bc944c03285611ac2739c450800ed35048edaa9f69458ddfeb"
    url "https://github.com/vercel/hyper/releases/download/v#{version}/Hyper-#{version}-mac-x64.zip",
        verified: "github.com/vercel/hyper/"
  else
    sha256 "66b3550de27ec0afde359e6fd5105176bd6446a7cfc11964636156bcbfb8724f"
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
