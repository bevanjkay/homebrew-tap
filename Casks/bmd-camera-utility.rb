cask "bmd-camera-utility" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "10.3.4,98c5057aa9494420948b5221c29bca41,968c59d1cd7848178a0c939e0f555266"
  sha256 "7b909e62ef1aa6cd618e0035de18d99ee2345f2f0f8f0d818a5663c45996971e"

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
