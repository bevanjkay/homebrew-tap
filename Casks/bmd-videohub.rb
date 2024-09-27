cask "bmd-videohub" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "10.0.0,5e3f35becfca43dfab67f57d08d5de47,960e27fc010840a1bc54a43423b8e106"
  sha256 "2406b6d3665705d2d3ae5d8cbe4a728ce89a5b39a94dcfb8cfd98453f987a627"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Videohub"
  desc "Control and update Blackmagic Videohub Devices"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "videohub"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Videohub #{version.csv.first.chomp(".0")}.pkg"

  uninstall launchctl: "com.blackmagic-design.videohub.server",
            pkgutil:   [
              "com.blackmagic-design.SmartControl",
              "com.blackmagic-design.Videohub",
              "com.blackmagic-design.Videohub2",
              "com.blackmagic-design.VideohubAssets",
              "com.blackmagic-design.VideohubUninstaller",
            ]

  zap trash: [
    "/Library/LaunchDaemons/com.blackmagic-design.videohub.server.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Control.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Setup.plist",
    "~/Library/Preferences/com.blackmagic.Videohub Hardware Panel Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.softwarecontrol.savedState",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.utility.savedState",
  ]
end
