cask "bmd-cintel" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "6.0.0,3d6d964a3ec94a5d8bc9084d2827b65f,60ef3d64394a448ba486be4b792fd450"
  sha256 "59cfe3abbc0601446a3a9ac5d73bc5353c59eb31531f91b915ee4431882b88d4"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Cintel"
  desc "Update and manage Blackmagic Cintel Scanner Hardware"
  homepage "https://www.blackmagicdesign.com/products/cintel"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "cintel"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Cintel #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Cintel/Uninstall Cintel.app/Contents/Resources/uninstall.sh",
              sudo:       true,
              args:       ["--path", "/Applications/Blackmagic Cintel/Uninstall Cintel.app/Contents/Resources"],
            },
            pkgutil: [
              "com.blackmagic-design.Cintel",
              "com.blackmagic-design.CintelAssets",
              "com.blackmagic-design.CintelUninstaller",
            ]

  zap trash: [
    "/Library/PreferencePanes/Blackmagic Cintel.prefPane",
    "~/Library/Preferences/com.blackmagic-design.Cintel Setup.plist",
  ]
end
