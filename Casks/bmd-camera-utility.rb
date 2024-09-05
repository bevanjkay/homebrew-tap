cask "bmd-camera-utility" do
  require "net/http"

  version "9.0.0,8b2be678ff2d42e783b515bc097aa999,c94e8a4445cf4766b46067487e12c726"
  sha256 "871a127da3e39e4caacde67470518606ffbe74b33047e5cb6c07c2e3ace2456e"

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
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "camera"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Cameras #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil: [
    "com.blackmagic-design.BlackmagicRaw",
    "com.blackmagic-design.BlackmagicRawSDK",
    "com.blackmagic-design.CameraControllers",
    "com.blackmagic-design.Cameras",
    "com.blackmagic-design.CamerasAssets",
    "com.blackmagic-design.CamerasUninstaller",
    "com.blackmagic-design.MiniRecorder",
    "com.blackmagic-design.SMPTEFiber",
  ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Camera Setup.plist"
end
