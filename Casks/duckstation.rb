cask "duckstation" do
  version "0.1-11391"
  sha256 "0d26198ad846508c0ce7857cd1aea44329192a1c70f9a8718f693ca6da3ea36c"

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
