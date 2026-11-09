cask "sevenzip-static" do
  arch arm: "mac", intel: "mac-x64"

  version "26.06"
  sha256 arm:   "b6f17920b4240940461dac8ef4009891881ac44d2a5ead625ede2ec8472185dd",
         intel: "3af68b124052da7fc2a246c96b0bea6a68bfee389baa788f4cead1a133445586"

  url "https://github.com/ip7z/7zip/releases/download/#{version}/7z#{version.no_dots}-#{arch}.tar.xz"
  name "7zip"
  desc "File archiver with a high compression ratio"
  homepage "https://7-zip.org/"

  livecheck do
    url "https://7-zip.org/download.html"
    regex(/>\s*Download\s+7-Zip\s+v?(\d+(?:\.\d+)+)\s+\([^)]+?\)/im)
  end

  binary "7zz"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/7zz"], must_succeed: false
  end

  zap :not_required
end
