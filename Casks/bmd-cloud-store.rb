cask "bmd-cloud-store" do
  require "net/http"

  version "1.4.0,3d18ff6a7bac4108bacc85c0f98c80a6,4b860cc4137b4f93b8aa9e6e511d7a1a"
  sha256 "7b584a7973aab49fa8bcccd42211016e8da70155cfcd1dadfeae8f790968d460"

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
  name "Blackmagic Cloud Store"
  desc "Update and manage Blackmagic Cloud Hardware"
  homepage "https://www.blackmagicdesign.com/products/blackmagiccloudpod"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "blackmagic-cloud-store"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Cloud Store #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Cloud Store/Uninstall Cloud Store.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.ManifestProxyGenerator",
              "com.blackmagic-design.SharedStorage",
              "com.blackmagic-design.SharedStorageAssets",
              "com.blackmagic-design.SharedStorageUninstaller",
            ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.Cloud Store Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.cloudstore.utility.savedState",
  ]
end
