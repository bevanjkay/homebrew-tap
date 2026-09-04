cask "sevenzip-static" do
  version "26.03"
  sha256 "5ca87677072c59f5602e5c49baa27d4694bacd2259b4e507f0094249d4281480"

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
