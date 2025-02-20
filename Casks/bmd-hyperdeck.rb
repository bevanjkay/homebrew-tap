cask "bmd-hyperdeck" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "8.5.2,3703d765d70e48ccb263935904bd018e,5a4ee845509e496eaea0c4fe57cd1612"
  sha256 "23761cf148c2e224ec4395ef589a610fc88e28d35a06e14290eddee8f9a391e3"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic HyperDeck"
  desc "Update and manage Blackmagic HyperDeck Hardwarecd"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "hyperdeck"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install HyperDeck #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic HyperDeck/Uninstall HyperDeck.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.HyperDeck",
              "com.blackmagic-design.HyperDeckAssets",
              "com.blackmagic-design.HyperDeckUninstaller",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.HyperDeck Setup.plist"
end
