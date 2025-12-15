cask "bmd-camera-prodock" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "1.0.0,c4fbd0761058424f9f48ceb20326f9c9,ab21e9cce39b44e1bc040eeafff9f963"
  sha256 "5f662247b9ad6ffff30577d7ec8fa22917dd28d39ae39c7a6dbb8579725f1921"

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
