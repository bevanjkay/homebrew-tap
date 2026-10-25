cask "rapidraw" do
  arch arm: "14_aarch64", intel: "15-intel_x64"

  version "1.6.7"
  sha256 arm:   "b3e9c3883686bff3209680bd2e4149b5dfb73df94ed788ec91cf8b3755d1bbca",
         intel: "6d711d4e4b8f1bfe77d2715a169d9e02b5c399977cbcfdff21b840f78b42f24a"

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
