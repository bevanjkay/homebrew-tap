cask "bmd-ultimatte" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "2.1.0,4c31b0a1d188409e808500ddedd9a47a,5816316c05304bab9fefcda162676879"
  sha256 "c0a2beb7ad73f12a20cca0b0bad70ae5cfbd35b337673e9a5116eac50c10f7ad"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Ultimatte"
  desc "Update and manage Blackmagic Ultimatte Hardware"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "ultimatte"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Ultimatte_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Ultimatte #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Ultimatte/Uninstall Ultimatte.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.Ultimatte",
              "com.blackmagic-design.UltimatteAssets",
              "com.blackmagic-design.UltimatteUninstaller",
            ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.Ultimatte Setup.plist",
    "~/Library/Preferences/com.blackmagicdesign.Ultimatte Software Control.plist",
  ]
end
