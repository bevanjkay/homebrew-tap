cask "bmd-smartview" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "5.0.4,18955bc8894e4ec8b013154597df0756,08b844b52e9d42f6a534a200ca762b94"
  sha256 "b1c3d5781596fedd4f8fb5693d1a0a3e406cb1c0822c5b2d536ecf3e2abb6dba"

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
