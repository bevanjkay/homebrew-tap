cask "duckstation" do
  version "0.1-10819"
  sha256 "4c321a621ab4c326eac3759f1df0e38864691c09f0a9e72fdd7d4869795a3e8f"

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
  depends_on macos: ">= :ventura"

  app "DuckStation.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/DuckStation.app"
  end

  zap trash: "~/Library/Application Support/DuckStation"
end
