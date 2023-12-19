cask "bmd-cloud-store" do
  require "net/http"

  version "1.1.6,9ba946cb738d47eab79db483cce136ad,2d5e6c41afe4468aa66f20f6928184a9"
  sha256 "e16b16d1e65e1a33b0e051dd99708291bb8e963452c9e5d838a37f9032203d92"

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
  container nested: "Blackmagic_Cloud_Store_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Cloud Store #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Cloud Store/Uninstall Cloud Store.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.SharedStorageUninstaller",
              "com.blackmagic-design.SharedStorageAssets",
              "com.blackmagic-design.SharedStorage",
              "com.blackmagic-design.ManifestProxyGenerator",
            ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.Cloud Store Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.cloudstore.utility.savedState",
  ]
end
