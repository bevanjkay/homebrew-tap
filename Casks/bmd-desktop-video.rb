cask "bmd-desktop-video" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "15.1.0,24cffaf9310849778bfea8b73e8459d9,e02f1faad1404c17943e06f1c1587cec"
  sha256 "f53599c657751bb92eaa37a89c807aa0afcb345b51b925db06f9c1c1026f15d3"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Desktop Video"
  desc "Device drivers and management tools for Blackmagic Design devices"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "desktop-video"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Desktop Video #{version.csv.first.chomp(".0")}.pkg"

  uninstall launchctl: [
              "com.blackmagic-design.DesktopVideo",
              "com.blackmagic-design.DesktopVideoDriverExtension.Helper",
              "com.blackmagic-design.DesktopVideoDriverExtensionRemove",
              "com.blackmagic-design.DesktopVideoDriverPostInstall",
            ],
            quit:      "com.blackmagic-design.BlackmagicDesktopVideoDriverExtension",
            pkgutil:   [
              "com.blackmagic-design.DesktopVideo",
              "com.blackmagic-design.DesktopVideoAssets",
              "com.blackmagic-design.DesktopVideoUninstaller",
              "com.blackmagic-design.DiskSpeedTest",
              "com.blackmagic-design.MediaExpress",
            ],
            delete:    "/Applications/Blackmagic Disk Speed Test.app"

  zap trash: [
    "/Library/LaunchDaemons/com.blackmagic-design.desktopvideo.XPCService.plist",
    "/Library/LaunchDaemons/com.blackmagic-design.DesktopVideoDriverExtension.Helper.plist",
    "/Library/LaunchDaemons/com.blackmagic-design.DesktopVideoHelper.plist",
    "/Library/PrivilegedHelperTools/com.blackmagic-design.DesktopVideoDriverExtension.Helper",
    "~/Library/Preferences/com.blackmagic-design.Blackmagic Desktop Video Administration.plist",
    "~/Library/Preferences/com.blackmagic-design.desktopvideo.livekey.plist",
    "~/Library/Saved Application State/com.blackmagic-design.desktopvideo.livekey.savedState",
  ]
end
