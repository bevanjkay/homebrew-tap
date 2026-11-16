cask "rapidraw" do
  arch arm: "15_aarch64", intel: "15-intel_x64"

  version "1.7.0"
  sha256 arm:   "19c0bb3d405b4c047e338884df5034be9f0a3f44669344f86254f9972d70dd06",
         intel: "d0561f9078fb7f348e46789f47eafe1b115ce5826926371cdc3d25203edd63db"

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
