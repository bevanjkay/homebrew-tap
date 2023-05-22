cask "bmd-cintel" do
  require "net/http"

  version "5.0.0,11a3ba20ff104be192e523725ded5625,2b2893eb27834d93a74cbb683e16a25a"
  sha256 "1b0d85ecb482f07776a3e48daa9bc531517b630acbe3c156635fa74c912df993"

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
  name "Blackmagic Cintel"
  desc "Update and manage Blackmagic Cintel Scanner Hardware"
  homepage "https://www.blackmagicdesign.com/products/cintel"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"cintel\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Cintel_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Cintel #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Cintel/Uninstall Cintel.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.CintelUninstaller",
              "com.blackmagic-design.CintelAssets",
              "com.blackmagic-design.Cintel",
            ]

  zap trash: [
    "/Library/PreferencePanes/Blackmagic Cintel.prefPane",
    "~/Library/Preferences/com.blackmagic-design.Cintel Setup.plist",
  ]
end
