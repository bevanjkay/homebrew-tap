cask "rapidraw" do
  arch arm: "15_aarch64", intel: "15-intel_x64"

  version "1.6.9"
  sha256 arm:   "c0cad5dd47332d0e8a95245cedc29a3410626c2f8a9820865f632c6e28cdb1c0",
         intel: "217055a49ad680ff9b890511406747e0dd9d72181325e1ac4bd6c32fee3e618a"

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
