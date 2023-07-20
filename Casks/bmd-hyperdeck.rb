cask "bmd-hyperdeck" do
  require "net/http"

  version "8.3.2,015997dc8024430a8678952bc58f8210,b5c741c3213348e1acec5ba28db650ec"
  sha256 "bd3c2d63bbde25eb83d80e95cfc1d51752acde6d66ba21710a23df375061d1f1"

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
