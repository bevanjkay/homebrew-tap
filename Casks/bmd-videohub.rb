cask "bmd-videohub" do
  require "net/http"

  version "9.0.0,fb9ad67472ea4012ab40dc9624e66be4,b9ac817cc491407583f459c15d0c5a6d"
  sha256 "3776204610e9b43c6a2642918ba098020c339e1088bd53efe8e9dd1282af88a1"

  url do
    params = {
      "platform"     => "Mac OS X",
      "downloadOnly" => "true",
      "country"      => "us",
      "policy"       => "true",
    }.to_json

    uri = URI("https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}")
    resp = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })

    resp.body
  end
  name "Blackmagic Videohub"
  desc "Control and update Blackmagic Videohub Devices"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "videohub"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Videohub_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Videohub #{version.csv.first.chomp(".0")}.pkg"

  uninstall pkgutil:   [
              "com.blackmagic-design.SmartControl",
              "com.blackmagic-design.VideohubUninstaller",
              "com.blackmagic-design.VideohubAssets",
              "com.blackmagic-design.Videohub",
              "com.blackmagic-design.Videohub2",
            ],
            launchctl: "com.blackmagic-design.videohub.server"

  zap trash: [
    "/Library/LaunchDaemons/com.blackmagic-design.videohub.server.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Control.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Setup.plist",
    "~/Library/Preferences/com.blackmagic.Videohub Hardware Panel Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.softwarecontrol.savedState",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.utility.savedState",
  ]
end
