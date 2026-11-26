cask "duckstation" do
  version "0.1-12777"
  sha256 "841881242eacf78e4d168bb2ae46ebd18eb93fcd0674b96ebde935b9f5b00fc4"

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
