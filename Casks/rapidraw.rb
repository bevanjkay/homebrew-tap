cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.3.10"
  sha256 arm:   "47bf74a7f765e493d8dd84705522180d7bc703cca2c5753edf437202c3816760",
         intel: "06dec373b69486408e258212c451d0766dd50181ae08f49421329e9c10177bea"

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
