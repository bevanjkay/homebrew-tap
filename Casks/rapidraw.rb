cask "rapidraw" do
  arch arm: "aarch64", intel: "x64"

  version "1.2.5"
  sha256 arm:   "93b9fd7e4113792b38678dad4b5d59cb8c22c6a018ee36f79922f0551e13f282",
         intel: "34841bbc1ac69a1906da885d4852844ec8658a8eb62adfb3bf53289242248fab"

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
