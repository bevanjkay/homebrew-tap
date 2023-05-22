cask "bmd-multiview" do
  require "net/http"

  version "2.2.5,ffbee5ff3bb744c39112959e4119c696,ba9774141d0148138d21ce6e7cb630f4"
  sha256 "c494900f70d50fb1d6a65df308226935f686ea6a2977c039d1266dfb0829ab53"

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
  name "Blackmagic Multiview"
  desc "Update and manage Blackmagic Multiview Hardware"
  homepage "https://www.blackmagicdesign.com/products/multiview"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"multiview\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_MultiView_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Multiview #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
    executable: "/Applications/Blackmagic MultiView/Uninstall MultiView.app/Contents/Resources/uninstall.sh",
    sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.MultiViewUninstaller",
              "com.blackmagic-design.MultiViewAssets",
              "com.blackmagic-design.MultiView",
            ]

            zap trash: [
              "~/Library/Preferences/com.blackmagic-design.MultiView Setup.plist",
              "~/Library/Saved Application State/com.blackmagic-design.multiview.utility.savedState",
            ]
end
