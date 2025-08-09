cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.3.6"
  sha256 arm:   "2b677507b57b4d1172e07ce538855e3c607ff51626b0c0687d96fcb4603951ad",
         intel: "c095f2a51df7a7e694a1c8b04bfffb4aa264c86b6fb19ec34dc7b826f64d0b17"

  url "https://github.com/CyberTimon/RapidRAW/releases/download/v#{version}/02_RapidRAW_v#{version}_macos-13_#{arch}.dmg"
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
