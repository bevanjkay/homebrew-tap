cask "sevenzip-static" do
  version "26.02"
  sha256 "1cf6760579502f87e591ff5c73a005ec50b3e4d6f507e8b038382d563c3175b9"

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
