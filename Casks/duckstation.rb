cask "duckstation" do
  version "0.1-10998"
  sha256 "ed8d58d6075bccb4d201b9ba3fab4e3cc1e967db311851cb44b131f7abf3f4e3"

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
