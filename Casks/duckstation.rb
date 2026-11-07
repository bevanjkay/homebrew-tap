cask "duckstation" do
  version "0.1-12442"
  sha256 "b9f6f0e747ee2617988de33e1fafdd17d02e918d042fed691355aed9a86c11cd"

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
