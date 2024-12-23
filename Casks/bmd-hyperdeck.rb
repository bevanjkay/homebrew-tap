cask "bmd-hyperdeck" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "8.5.0,0728cd028cf04b90a3a8b549de352912,0c96e606abf741beb3af6cf17b8d1117"
  sha256 "2b4228b7fe54d125ad548315c88a1708fe0210c45d3b857cd361fd08872e5568"

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
