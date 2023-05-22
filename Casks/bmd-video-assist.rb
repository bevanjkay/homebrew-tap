cask "bmd-video-assist" do
  require "net/http"

  version "3.9.0,872df2f68a214344b4fcc6a3344ba596,f4f08e89360f4453a915cd18a3423608"
  sha256 "8d42a088e71b1eedca0ab050bb29de5ed9bd9a8cb75dfdd681b39a1097e0a1c1"

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
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"videoassist\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Video_Assist_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Video Assist #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Video Assist/Uninstall Video Assist.app/Contents/Resources/uninstall.sh",
              sudo:       true,
              args:      ["--path", "/Applications/Blackmagic Video Assist/Uninstall Video Assist.app/Contents/Resources"],
            },
            pkgutil: [
              "com.blackmagic-design.VideoAssistUninstaller",
              "com.blackmagic-design.VideoAssistAssets",
              "com.blackmagic-design.VideoAssist",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Video Assist Setup.plist"
end
