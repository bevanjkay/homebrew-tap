cask "sevenzip-static" do
  version "25.00"
  sha256 "fc7bf340ce41b1ef08eb468e2900152a61ca83dc227d925ac73f49c1ea1f59a2"

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
