cask "bmd-multiview" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "2.2.5,ffbee5ff3bb744c39112959e4119c696,ba9774141d0148138d21ce6e7cb630f4"
  sha256 "c494900f70d50fb1d6a65df308226935f686ea6a2977c039d1266dfb0829ab53"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Multiview"
  desc "Update and manage Blackmagic Multiview Hardware"
  homepage "https://www.blackmagicdesign.com/products/multiview"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "multiview"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Multiview #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic MultiView/Uninstall MultiView.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.MultiView",
              "com.blackmagic-design.MultiViewAssets",
              "com.blackmagic-design.MultiViewUninstaller",
            ]

  zap trash: [
    "~/Library/Preferences/com.blackmagic-design.MultiView Setup.plist",
    "~/Library/Saved Application State/com.blackmagic-design.multiview.utility.savedState",
  ]
end
