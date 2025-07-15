cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.6"
  sha256 arm:   "1dae33c9e25b5554700de7e8bd5974d6ccab30c92606d911c0761094b363d0ba",
         intel: "f705c1e9033769d2caf7916878ee70e8b1475b4fb145194a2756f55b4966845c"

  url "https://github.com/CyberTimon/RapidRAW/releases/download/v#{version}/RapidRAW_v#{version}_macos_#{arch}.dmg"
  name "RapidRAW"
  desc "GPU-accelerated RAW image editor"
  homepage "https://github.com/CyberTimon/RapidRAW"

  depends_on macos: ">= :high_sierra"

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
