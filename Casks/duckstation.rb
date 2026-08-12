cask "duckstation" do
  version "0.1-11609"
  sha256 "692e54a838a7bc6525a848677f587f90283222f2c24c3a20c9277933c311b7f4"

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
