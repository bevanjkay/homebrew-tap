cask "bmd-camera-utility" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "10.2.2,3f3d8471172a41b9a0ad1ebdf2c7c279,a426a87bc592412ea8e5b39fbbe1528f"
  sha256 "d99abc9be8609d6c5b435de322edf22ced7cc131f9da60baf115ca5823e14e20"

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
  depends_on :macos

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
