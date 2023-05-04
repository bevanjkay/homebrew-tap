cask "bmd-camera-utility" do
  require "net/http"

  version "8.1.1,b1cb16f2eda940c4872cb1e17c6bc7ca,84f3c73e59ad47f29a99a38d618fbe7a"
  sha256 "68ab76b65f34122405dacca1c3976a918f79ba92c4addb28dc8b5ec93d99dfcc"

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
