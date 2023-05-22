cask "bmd-web-presenter" do
  require "net/http"

  version "3.2.0,da986c4de04b4008876c631a53d8dfef,5497af8bcd9a47b39f9e99ad139c8cf2"
  sha256 "6fc46d372587fec09ab92ae6258bfcc1da170597a478bbc2bb19f3779d3d09a5"

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
  name "Blackmagic Web Presenter"
  desc "Update and manage Blackmagic Web Presenter Hardware"
  homepage "https://www.blackmagicdesign.com/products/blackmagicwebpresenter"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"web-presenter\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Web_Presenter_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Web Presenter #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Web Presenter/Uninstall Web Presenter.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.WebPresenterUninstaller",
              "com.blackmagic-design.WebPresenterAssets",
              "com.blackmagic-design.WebPresenter",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Web Presenter Setup.plist"
end
