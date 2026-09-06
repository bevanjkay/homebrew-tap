cask "rapidraw" do
  arch arm: "14_aarch64", intel: "15-intel_x64"

  version "1.6.3"
  sha256 arm:   "949aea4fb2ee9bd3e7fbcc1af63a1076b81d68a4ca6a11c31fdf6a909ccc913a",
         intel: "220aab47c66ce710a7a25206cde67dfcd7bc9a102ac654c1aff7962a807efa17"

  url "https://github.com/CyberTimon/RapidRAW/releases/download/v#{version}/02_RapidRAW_v#{version}_macos-#{arch}.dmg"
  name "RapidRAW"
  desc "GPU-accelerated RAW image editor"
  homepage "https://github.com/CyberTimon/RapidRAW"

  depends_on macos: :ventura

  app "RapidRAW.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/RapidRAW.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/com.rapidraw.app",
    "~/Library/Caches/com.rapidraw.app",
    "~/Library/Preferences/com.rapidraw.app.plist",
    "~/Library/WebKit/com.rapidraw.app",
  ]
end
