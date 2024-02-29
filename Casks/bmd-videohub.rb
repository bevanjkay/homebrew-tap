cask "bmd-videohub" do
  require "net/http"

  version "9.0.1,2b583c1d7ac040e39ef41b9304040730,f0da254b098345e3affd7381cf5a5ce3"
  sha256 "0504acfb80c240213f237b3e1dbc9c222d1cdb6fd30f4cdc61904f36a2abe66e"

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

  uninstall launchctl: "com.blackmagic-design.videohub.server",
            pkgutil:   [
              "com.blackmagic-design.SmartControl",
              "com.blackmagic-design.Videohub",
              "com.blackmagic-design.Videohub2",
              "com.blackmagic-design.VideohubAssets",
              "com.blackmagic-design.VideohubUninstaller",
            ]

  zap trash: [
    "/Library/LaunchDaemons/com.blackmagic-design.videohub.server.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Control.plist",
    "~/Library/Preferences/com.blackmagic-design.Videohub Setup.plist",
    "~/Library/Preferences/com.blackmagic.Videohub Hardware Panel Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.softwarecontrol.savedState",
    "~/Library/Saved Application State/com.blackmagic-design.videohub.utility.savedState",
  ]
end
