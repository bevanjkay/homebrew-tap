cask "duckstation" do
  version "0.1-12640"
  sha256 "ccffb8befadbe8052f468383f2ce9aa6d8f4a82f2e3a9aceebbad6e3f59dc0ce"

  url "https://github.com/stenzek/duckstation/releases/download/v#{version}/duckstation-mac-release.zip"
  name "DuckStation"
  desc "Fast PlayStation 1 emulator"
  homepage "https://www.duckstation.org/"

  livecheck do
    url :url
    regex(/v?(\d+(?:[.-]\d+)+)/i)
  end

  auto_updates true
  depends_on macos: :ventura

  app "DuckStation.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/DuckStation.app"], must_succeed: false
  end

  uninstall quit: "com.github.stenzek.duckstation"

  zap trash: "~/Library/Application Support/DuckStation"
end
