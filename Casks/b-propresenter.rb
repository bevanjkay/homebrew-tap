cask "b-propresenter" do
  version "7.11,118161413"
  sha256 "33ad8cae003ec48b59cca001054e2571066501bbbfca9e1acc1d13305e8a8629"

  url "https://renewedvision.com/downloads/propresenter/mac/ProPresenter_#{version.csv.first}_#{version.csv.second}.zip"
  name "ProPresenter"
  desc "Presentation and production application for live events"
  homepage "https://www.renewedvision.com/propresenter.php"

  livecheck do
    skip "Version control is manual for this cask"
  end

  conflicts_with cask: [
    "homebrew/cask-versions/propresenter-beta",
    "propresenter",
  ]
  depends_on macos: ">= :mojave"

  app "ProPresenter.app"

  zap trash: [
        "~/Library/Application Support/RenewedVision/ProPresenter#{version.major}",
        "~/Library/Caches/KSCrashReports/ProPresenter #{version.major}",
        "~/Library/Caches/Sessions/ProPresenter #{version.major}",
        "~/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "~/Library/Preferences/com.renewedvision.ProPresenter#{version.major}.plist",
        "/Library/Application Support/RenewedVision",
        "/Library/Caches/com.renewedvision.ProPresenter#{version.major}",
        "/Users/Shared/Renewed Vision Media",
      ],
      rmdir: [
        "~/Library/Application Support/RenewedVision",
        "~/Library/Caches/KSCrashReports",
        "~/Library/Caches/Sessions",
      ]
end
