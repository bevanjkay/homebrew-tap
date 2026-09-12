cask "duckstation" do
  version "0.1-11826"
  sha256 "1870ef7c34f619861cf9bedfe73772cb2106061058ce6e40a7b41dc328835a96"

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

  zap trash: "~/Library/Application Support/DuckStation"
end
