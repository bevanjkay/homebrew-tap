cask "bmd-camera-utility" do
  require "net/http"

  version "8.5.0,15cdfe023fb541ca93163fcada9b1d76,b6a734633add4c8c90368f7ea3625b59"
  sha256 "ee08ade51c679ba70a09bd797a96210e6fc5b1e16cb3335e5151de656d97cec4"

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
  name "Blackmagic Camera Utility"
  desc "Update and manage Blackmagic Cameras"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"camera\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Camera_Setup_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Cameras #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil: [
    "com.blackmagic-design.CameraControllers",
    "com.blackmagic-design.MiniRecorder",
    "com.blackmagic-design.BlackmagicRawSDK",
    "com.blackmagic-design.BlackmagicRaw",
    "com.blackmagic-design.SMPTEFiber",
    "com.blackmagic-design.CamerasUninstaller",
    "com.blackmagic-design.CamerasAssets",
    "com.blackmagic-design.Cameras",
  ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.Camera Setup.plist",
  ]
end
