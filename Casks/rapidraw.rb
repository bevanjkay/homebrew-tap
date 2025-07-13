cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.4"
  sha256 arm:   "8fdaa7518fcb26908f80de425cb2bb9bbedd5f9d47e11732f547773b75cba836",
         intel: "2b8515c76517bdebe8414857a7f497648398b68db6a858e80e6f62297f0718cb"

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
