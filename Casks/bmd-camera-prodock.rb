cask "bmd-camera-prodock" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "1.1.0,4b6b8fcb77fc4348bb0169a693c89405,c03765465b0846c59a8a6117bdb7536f"
  sha256 "616b4d4f2a2a654f993a8f12a978d600c598b191618a8c68856a315ae38b5c36"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Camera Prodock"
  desc "Update and manage Blackmagic Camera Prodock"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        next false if download["urls"]["Mac OS X"].first["product"] != "camera"

        download["urls"]["Mac OS X"].first["downloadTitle"].match?(/ProDock/i)
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Camera Prodock #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil: [
    "com.blackmagic-design.StoneCutter",
    "com.blackmagic-design.StoneCutterAssets",
    "com.blackmagic-design.StoneCutterUninstaller",
  ]

  zap trash: [
    "~/Library/Caches/Camera ProDock Setup",
    "~/Library/Preferences/com.blackmagic-design.Camera ProDock Setup.plist",
  ]
end
