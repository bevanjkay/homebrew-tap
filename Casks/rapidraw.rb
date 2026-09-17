cask "rapidraw" do
  arch arm: "14_aarch64", intel: "15-intel_x64"

  version "1.6.4"
  sha256 arm:   "6ca245b1c8089b693395b1c215eb222bd133045e481cb91e7ad95e53b092d212",
         intel: "2a96adc5b12be70692e8aa75575f9bfce52cb4f4c11236b562fdaa1ff8c01879"

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
