cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.1"
  sha256 "20d7c72eb5bfb1dd03e5475a6312d8e9987b63a0605c2b5686cebd901815034b"

  url "https://github.com/CyberTimon/RapidRAW/releases/download/v#{version}/RapidRAW_#{version}_#{arch}.dmg"
  name "RapidRAW"
  desc "GPU-accelerated RAW image editor"
  homepage "https://github.com/CyberTimon/RapidRAW"

  depends_on macos: ">= :high_sierra"

  app "RapidRAW.app"

  postflight do
    file_path = "#{appdir}/RapidRAW.app"
    quarantine_value = `xattr -p com.apple.quarantine "#{file_path}" 2>/dev/null`.strip
    if $CHILD_STATUS.success? && !quarantine_value.empty?
      system "xattr", "-d", "com.apple.quarantine", file_path
    else
      odie "RapidRAW is already marked as safe. Please remove the postflight block"
    end
  end

  zap trash: [
    "~/Library/Application Support/com.rapidraw.app",
    "~/Library/Caches/com.rapidraw.app",
    "~/Library/Preferences/com.rapidraw.app.plist",
    "~/Library/WebKit/com.rapidraw.app",
  ]
end
