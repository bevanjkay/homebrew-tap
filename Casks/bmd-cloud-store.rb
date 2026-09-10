cask "bmd-cloud-store" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "2.0.0,656ce7412a8d4679b85c7ae9c46f583c,294d804c879445b780479b614f328e33"
  sha256 "352f7621f5641eb5e800d263dc0f39c3d84d2741b13bd1426bc15e5c935c3554"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
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
  depends_on :macos

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
