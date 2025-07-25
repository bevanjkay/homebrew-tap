cask "bmd-video-assist" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "3.21.0,1640fedcf957470cb757bd61e949c45d,a9c59b92038849af9f9d884794841041"
  sha256 "651ab8491248050ec5c72ea7c1b38350d622349f826e5c7b217c5419b12b2e58"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Video Assist"
  desc "Update and manage Blackmagic Video Assist Hardware"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "videoassist"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Video Assist #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Video Assist/Uninstall Video Assist.app/Contents/Resources/uninstall.sh",
              sudo:       true,
              args:       ["--path",
                           "/Applications/Blackmagic Video Assist/Uninstall Video Assist.app/Contents/Resources"],
            },
            pkgutil: [
              "com.blackmagic-design.VideoAssist",
              "com.blackmagic-design.VideoAssistAssets",
              "com.blackmagic-design.VideoAssistUninstaller",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Video Assist Setup.plist"
end
