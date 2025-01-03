cask "sevenzip-static" do
  version "24.09"
  sha256 "073b6fa8dc5d9adb6f742888d0d75f5767406b503199b9704ccbf61133a21ded"

  url "https://7-zip.org/a/7z#{version.no_dots}-mac.tar.xz"
  name "7zip"
  desc "File archiver with a high compression ratio"
  homepage "https://7-zip.org/"

  livecheck do
    url "https://7-zip.org/download.html"
    regex(/>\s*Download\s+7-Zip\s+v?(\d+(?:\.\d+)+)\s+\([^)]+?\)/im)
  end

  binary "7zz"

  # No zap stanza required

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/7zz"
  end
end
