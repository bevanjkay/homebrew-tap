cask "bmd-videohub" do
  require "net/http"

  version "7.0.8,7b39137c897b4e5ea859a9f4869af0fe,1a6d8412dc7544fd8bd2888551962858"
  sha256 "3ad656316d99362f5e9d74c28cb593167756034f25d78b75e9eb6e285fac8f36"

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

  container nested: "Blackmagic_Videohub_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Videohub #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil:   [
              "com.blackmagic-design.SmartControl",
              "com.blackmagic-design.VideohubUninstaller",
              "com.blackmagic-design.VideohubAssets",
              "com.blackmagic-design.Videohub",
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
