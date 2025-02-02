cask "bmd-smartview" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "5.0.1,fcdfaf788017439f875a3e0d00c38c7c,0621bf89cbdd4d9389438a3a5c7b7095"
  sha256 "693943eae0762a51eea1d64b6b43a146a9a9cc87a41967160a3f04d6dfc94ece"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic SmartView"
  desc "Update and manage Blackmagic Teranex Hardware"
  homepage "https://www.blackmagicdesign.com/products/teranex"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "smartview"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install SmartView #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic SmartView/Uninstall SmartView.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: "com.blackmagic-design.SmartView*"

  zap trash: [
    "~/Library/Caches/SmartView Setup",
    "~/Library/Preferences/com.blackmagic-design.SmartView Setup.plist",
  ]
end
