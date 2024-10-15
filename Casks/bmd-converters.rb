cask "bmd-converters" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "10.1.1,13fdae1e7f4a4b5b8c4a4f64ca99c288,13c5c21da1c84d8cbd369a6246ee2792"
  sha256 "a9cd67a1d56b0220117891592c5eff6f82c203e6c41921fd8afbf33cb087cb57"

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

  pkg "Install Converters #{version.csv.first.chomp(".0").chomp(".1")}.pkg"

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
