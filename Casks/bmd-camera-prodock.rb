cask "bmd-camera-prodock" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "1.1.1,b51d656a0630467a93045f9c9dbee73b,55d727b2d5af491eb141e37374a851d5"
  sha256 "8ea16d33f4f539c6ac22f5afa74e712b64796923713902fdb4f198d17dc68fa0"

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
  depends_on :macos

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
