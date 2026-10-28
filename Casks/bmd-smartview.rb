cask "bmd-smartview" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "5.0.5,78dd5d68637d4ba1a6935d808b6a2d30,919505c47808453589be8b970d2a1e64"
  sha256 "938b1ba0145ab2336b87de7bcc2014d00c481a3f521508655b281c8f2c8344c1"

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
  depends_on :macos

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
