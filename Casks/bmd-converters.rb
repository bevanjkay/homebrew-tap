cask "bmd-converters" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "12.1.0,4372a1ee67c7441da51f68747c7030d7,42b1fe05d0364af0835de393d19a6d44"
  sha256 "7d35764d5f63922be69e4e2e95d598d4b2c5760b6f9fd245e046ea4295cdec47"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Converters"
  desc "Utility to update and control Blackmagic Design Converters"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "converters"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Converters #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil: [
    "com.blackmagic-design.Converters",
    "com.blackmagic-design.ConvertersAssets",
    "com.blackmagic-design.ConvertersUninstaller",
    "com.blackmagic-design.IPVideo2",
    "com.blackmagic-design.MicConverter",
    "com.blackmagic-design.MicroConverters",
  ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.Converters Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.converters.utility.savedState",
  ]
end
