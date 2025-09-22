cask "bmd-camera-utility" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "9.9.1,af3cee245fa64dbfb15ecedc628676b3,388e93b1b6d8462cbf444b839fb1010a"
  sha256 "4ab8df1f36604762716550391d3c84fc5d042db8d93f373c20072832929cfc59"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
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
