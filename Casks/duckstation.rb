cask "duckstation" do
  version "0.1-12083"
  sha256 "cd77d80b55276f15340efa1c65df250f8f4d413b68d1c136e48615d780f1249c"

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
