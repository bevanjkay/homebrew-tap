cask "bmd-atem" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "9.8.1,2b59d2ae9db6421f9f90cb2fab55f60b,a7073224fa424e489afb5942dc4d221f"
  sha256 "8c897b135ac5cb161c718cab26f55627f62ef9cc3a718160e4991b093b7b43b8"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic ATEM"
  desc "Update and manage Blackmagic ATEM Switchers"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "atem"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install ATEM #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic ATEM Switchers/Uninstall ATEM.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.StreamingBridge",
              "com.blackmagic-design.Switchers",
              "com.blackmagic-design.SwitchersAssets",
              "com.blackmagic-design.SwitchersUninstaller",
            ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.ATEM Setup.plist",
    "~/Library/Preferences/com.blackmagic-design.ATEM Software Control.plist",
    "~/Library/Saved Application State/com.blackmagic-design.switchers.softwarecontrol.savedState",
  ]
end
