cask "bmd-desktop-video" do
  require "net/http"

  version "12.4.2,de2c011b1e684bf88cefefe6ff4fde21,cdc57be479ba4af1ab6dfdbfdac5627f"
  sha256 ""

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
  name "Blackmagic Desktop Video"
  desc "Device drivers and management tools for Blackmagic Design devices"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"desktop-video\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  container nested: "Blackmagic_Desktop_Video_#{version.csv.first}.dmg"
  pkg "Install Desktop Video #{version.csv.first}.pkg"

  zap trash: [
    "/Library/LaunchDaemons/com.blackmagic-design.DesktopVideoDriverExtension.Helper.plist",
    "/Library/LaunchDaemons/com.blackmagic-design.DesktopVideoHelper.plist",
    "/Library/LaunchDaemons/com.blackmagic-design.desktopvideo.XPCService.plist",
    "~/Library/Preferences/com.blackmagic-design.desktopvideo.livekey.plist",
    "/Library/PrivilegedHelperTools/com.blackmagic-design.DesktopVideoDriverExtension.Helper",
    "~/Library/Saved Application State/com.blackmagic-design.desktopvideo.livekey.savedState",
  ]
end
