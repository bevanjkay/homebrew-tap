cask "rapidraw" do
  arch arm: "15_aarch64", intel: "15-intel_x64"

  version "1.7.1"
  sha256 arm:   "14f06525f3455518a09788271b000bc7abb4a90277c93726b11470ae77848c3f",
         intel: "5151dbc39133ba8efb254471f1479b1a2250ba276a412a512bfc042e0e96a5de"

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
