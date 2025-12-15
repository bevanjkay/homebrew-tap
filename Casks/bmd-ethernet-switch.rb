cask "bmd-ethernet-switch" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "1.1.0,9ab93e42cdac495b99441b77e9b79487,5dfef21a04c6415fae810a80f01fe240"
  sha256 "ab58031a9bf44c356d4b97dac2d955539ee4093934187305bef44e11f39f2b61"

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
