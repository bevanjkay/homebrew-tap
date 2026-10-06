cask "sevenzip-static" do
  version "26.04"
  sha256 "bee04358cbcbc7106273cee0e8d72916db2696c48067a3538c34d8cd6fd16578"

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

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/7zz"], must_succeed: false
  end
end
