cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.10"
  sha256 arm:   "bb513a986c22aaac6a2544d5ea1ac5edfef13d1145c4d029a7bf8cebd14e99bb",
         intel: "c06867f95207a12b0d75fa6c199dd86b79b84af5839253dbd7eb0c75c01e84fa"

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
