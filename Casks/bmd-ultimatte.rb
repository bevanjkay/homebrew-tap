cask "bmd-ultimatte" do
  require "net/http"

  version "2.0.3,b521619300e74352a111f7804a2dcaa3,a8bd4ffed1174604aae997e5335a476f"
  sha256 "93658428171119901ccd60466df4b8dce03b7b12eca7df69811ce209e6c55909"

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
  name "Blackmagic Ultimatte"
  desc "Update and manage Blackmagic Ultimatte Hardware"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"ultimatte\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Ultimatte_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Ultimatte #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Ultimatte/Uninstall Ultimatte.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.UltimatteUninstaller",
              "com.blackmagic-design.UltimatteAssets",
              "com.blackmagic-design.Ultimatte",
            ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.Ultimatte Setup.plist",
    "~/Library/Preferences/com.blackmagicdesign.Ultimatte Software Control.plist",
  ]
end
