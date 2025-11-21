cask "bmd-atem" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "10.1.1,78398c4ec6ac4c69b97e8d7841fa14a9,f85f2f962b874d76b4e3c2bd5bbb73ed"
  sha256 "d373a297278f193200bdae680879e78c3c06536fb3b0d3b7c7211a387592acfb"

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
