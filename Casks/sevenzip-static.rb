cask "sevenzip-static" do
  version "25.01"
  sha256 "26aa75bc262bb10bf0805617b95569c3035c2c590a99f7db55c7e9607b2685e0"

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
