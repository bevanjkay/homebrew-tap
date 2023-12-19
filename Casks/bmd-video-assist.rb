cask "bmd-video-assist" do
  require "net/http"

  version "3.14.0,751ad198e82d48e694ef9494e92a60d4,c543b8458a874d29af7e79c3568b5e95"
  sha256 "fd629eb0b6f0b826f754c39fd1a6196191d66983c43cc144cbca40503e4b197d"

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
  name "Blackmagic Video Assist"
  desc "Update and manage Blackmagic Video Assist Hardware"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "videoassist"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Video_Assist_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Video Assist #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Video Assist/Uninstall Video Assist.app/Contents/Resources/uninstall.sh",
              sudo:       true,
              args:       ["--path",
                           "/Applications/Blackmagic Video Assist/Uninstall Video Assist.app/Contents/Resources"],
            },
            pkgutil: [
              "com.blackmagic-design.VideoAssistUninstaller",
              "com.blackmagic-design.VideoAssistAssets",
              "com.blackmagic-design.VideoAssist",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Video Assist Setup.plist"
end
