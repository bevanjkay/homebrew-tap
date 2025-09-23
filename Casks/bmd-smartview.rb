cask "bmd-smartview" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "5.0.3,657731b0094543ceac66211017f2bf27,dda8f0bca6eb4037b9386079ec980386"
  sha256 "b4c6e1c03e126b3af7cb12c94e5719951916f110f55ef1a2c0a03ef241143bd4"

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
