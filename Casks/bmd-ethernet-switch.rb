cask "bmd-ethernet-switch" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "2.0.0,29ccd57d20be4dceb3be8f2dac64d97c,6e2a0c172a714efbbfd27ae4c27102f2"
  sha256 "14f71675c1fd00dcd4743527227ebc15eb092b4a379c3d562549b45ae4c23759"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Ethernet Switch"
  desc "Update and manage Blackmagic Ethernet Switches"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        next false if download["urls"]["Mac OS X"].first["product"] != "videohub"

        download["urls"]["Mac OS X"].first["downloadTitle"].match?(/Ethernet/i)
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

  pkg "Install Ethernet Switch #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil: [
    "com.blackmagic-design.EthernetSwitch",
    "com.blackmagic-design.EthernetSwitchAssets",
    "com.blackmagic-design.EthernetSwitchUninstaller",
  ]

  zap trash: [
    "~/Library/Caches/Ethernet Switch Setup",
    "~/Library/Preferences/com.blackmagic-design.Ethernet Switch Setup.plist",
  ]
end
