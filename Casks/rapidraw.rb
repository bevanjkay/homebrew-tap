cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.3"
  sha256 arm:   "cf999a6fa3b7d659731bfbba2da79d64ae47e51564d891bfb351217d20eeecfe",
         intel: "f2d700340851147a0da71231c57d58d794eca65441428d3b786284bb047dd2c0"

  url "https://github.com/CyberTimon/RapidRAW/releases/download/v#{version}/RapidRAW_v#{version}_macos_#{arch}.dmg"
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
