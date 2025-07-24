cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.12"
  sha256 arm:   "4a4d32c00f2f8a902755fa23fd96722a66467d6c81e992160214134459c06c04",
         intel: "008aae1d7f0f27e3c4b5f5a77c59d66e5ae7b982cdc4a96ebe1910bf5ebe5bed"

  url "https://github.com/CyberTimon/RapidRAW/releases/download/v#{version}/02_RapidRAW_v#{version}_macos_#{arch}.dmg"
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
