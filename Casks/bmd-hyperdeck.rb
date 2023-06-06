cask "bmd-hyperdeck" do
  require "net/http"

  version "8.3.1,22a19d5b5c83459a904b560997a36a7c,0afca87b8c30470cac6456b8de831fa9"
  sha256 "cab49f3aa5d2cc381097e42f384234a5e0065e32160bbeceb09765c764d35822"

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
  name "Blackmagic HyperDeck"
  desc "Update and manage Blackmagic HyperDeck Hardwarecd"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"hyperdeck\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_HyperDeck_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install HyperDeck #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic HyperDeck/Uninstall HyperDeck.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.HyperDeckUninstaller",
              "com.blackmagic-design.HyperDeckAssets",
              "com.blackmagic-design.HyperDeck",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.HyperDeck Setup.plist"
end
