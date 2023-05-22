cask "bmd-teranex" do
  require "net/http"

  version "7.1.7,583104158c604f65ac35cef95587410d,268c803a889542a699d3795c4114cf73"
  sha256 "a6195febd8f73ade38bc1ba62c6bc579c20fcfe31ede4b5b11df362ecf79fea2"

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
  name "Blackmagic Teranex"
  desc "Update and manage Blackmagic Teranex Hardware"
  homepage "https://www.blackmagicdesign.com/products/teranex"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"teranex\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Teranex_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Teranex #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Teranex/Uninstall Teranex.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.TeranexMini",
              "com.blackmagic-design.TeranexUninstaller",
              "com.blackmagic-design.TeranexAssets",
              "com.blackmagic-design.Teranex",
            ],
            delete:  [
              "/Applications/Blackmagic Teranex/Teranex Setup.app",
              "/Applications/Blackmagic Teranex/Uninstall Teranex.app",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Teranex Setup.plist"
end
