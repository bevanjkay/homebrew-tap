cask "bmd-cintel" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "7.0.0,de9610f923514bffbf5dd5c6d9b2fb17,bc151f766409428aa7c834d00098498f"
  sha256 "362e4f8dce6861d1ce36615d2acbcf2706636083341738eb507a2f57910a1f42"

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

  uninstall pkgutil: [
              "com.blackmagic-design.Cintel",
              "com.blackmagic-design.CintelAssets",
              "com.blackmagic-design.CintelUninstaller",
            ],
            delete:  "/Applications/Blackmagic Cintel/Blackmagic Cintel Setup.app"

  zap trash: [
    "/Library/PreferencePanes/Blackmagic Cintel.prefPane",
    "~/Library/Preferences/com.blackmagic-design.Cintel Setup.plist",
  ]
end
