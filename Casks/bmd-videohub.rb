cask "bmd-videohub" do
  require "net/http"

  version "8.0.1,5692bab8deaa4da8a46d64d9f962784f,2a2c157525f34f42a4835683c8aa6a71"
  sha256 "76d218bb114e8864cd9d270b996f435b550ae1f8f9c13e2895a0478ddd45b879"

  url do
    params = {
      "platform"     => "Mac OS X",
      "downloadOnly" => "true",
      "country"      => "us",
      "policy"       => "true",
    }.to_json

    uri = URI("https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}")
    resp = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })

    resp.body
  end
  name "Blackmagic Videohub"
  desc "Control and update Blackmagic Videohub Devices"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"videohub\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Videohub_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Videohub #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil:   [
              "com.blackmagic-design.SmartControl",
              "com.blackmagic-design.VideohubUninstaller",
              "com.blackmagic-design.VideohubAssets",
              "com.blackmagic-design.Videohub",
              "com.blackmagic-design.Videohub2",
            ],
            launchctl: "com.blackmagic-design.videohub.server"

  zap trash: [
    "/Library/LaunchDaemons/com.blackmagic-design.videohub.server.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Control.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Setup.plist",
    "~/Library/Preferences/com.blackmagic.Videohub Hardware Panel Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.softwarecontrol.savedState",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.utility.savedState",
  ]
end
