cask "bmd-atem" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "10.4.0,45adf85e999e46399299b8f74882c70d,2337b0f5970a4700a1395aa73039d7fb"
  sha256 "639e7df1ee2592bf8f5cc5576f4cfbfb9e912b5643002e92002e38d7f65948f1"

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
  depends_on :macos

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
