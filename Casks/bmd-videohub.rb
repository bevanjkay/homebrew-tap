cask "bmd-videohub" do
  require "net/http"

  version "8.0.0,2e096119931e4e4f88c8fca21687c1d2,8ba96f1e3bd9485c922e9fffeb5a4474"
  sha256 "b7dd820b1120a1955b84db863dfde5fd0676ec58d2f6cf589250f9e230c7447a"

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
