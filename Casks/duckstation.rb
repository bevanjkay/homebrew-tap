cask "duckstation" do
  version "0.1-11580"
  sha256 "6b26a514bd87edfd628f0c5e766436c4e339eb3e1a1bfd4dc047b28019479574"

  url "https://github.com/stenzek/duckstation/releases/download/v#{version}/duckstation-mac-release.zip",
      verified: "github.com/stenzek/duckstation/"
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

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/DuckStation.app"
  end

  zap trash: "~/Library/Application Support/DuckStation"
end
