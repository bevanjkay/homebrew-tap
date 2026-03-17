cask "bmd-ultimatte" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "2.4.1,faf238fd48f3412ba64649da82f81011,3a51acbcacc94513985747942ae80962"
  sha256 "fe88227594e90900bc3a20f51d7cfcd2a488d051e225280d7687160a47598b49"

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
