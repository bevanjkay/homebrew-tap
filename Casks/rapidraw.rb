cask "rapidraw" do
  arch arm: "14_aarch64", intel: "15-intel_x64"

  version "1.6.2"
  sha256 arm:   "a8788d545af2862a29788a75ef7fafb9f6a7c44f4d5bfd8be9d187a307602fbd",
         intel: "3477739e53fd14082097ac0e56cd38153a3955064aeef0d8a492ed0841b6a520"

  url "https://github.com/CyberTimon/RapidRAW/releases/download/v#{version}/02_RapidRAW_v#{version}_macos-#{arch}.dmg"
  name "RapidRAW"
  desc "GPU-accelerated RAW image editor"
  homepage "https://github.com/CyberTimon/RapidRAW"

  depends_on macos: :ventura

  app "RapidRAW.app"

  postflight do
    file_path = "#{appdir}/RapidRAW.app"
    quarantine_value = `spctl --assess --type execute "#{file_path}" 2>/dev/null`.strip
    if $CHILD_STATUS.success? && !quarantine_value.empty?
      odie "RapidRAW is already marked as safe. Please remove the postflight block"
    else
      system "xattr", "-d", "com.apple.quarantine", file_path
    end
  end

  zap trash: [
    "~/Library/Application Support/com.rapidraw.app",
    "~/Library/Caches/com.rapidraw.app",
    "~/Library/Preferences/com.rapidraw.app.plist",
    "~/Library/WebKit/com.rapidraw.app",
  ]
end
