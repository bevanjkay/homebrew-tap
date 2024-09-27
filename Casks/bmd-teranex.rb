cask "bmd-teranex" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "7.1.7,583104158c604f65ac35cef95587410d,268c803a889542a699d3795c4114cf73"
  sha256 "a6195febd8f73ade38bc1ba62c6bc579c20fcfe31ede4b5b11df362ecf79fea2"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Teranex"
  desc "Update and manage Blackmagic Teranex Hardware"
  homepage "https://www.blackmagicdesign.com/products/teranex"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "teranex"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Teranex_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Teranex #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Teranex/Uninstall Teranex.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.Teranex",
              "com.blackmagic-design.TeranexAssets",
              "com.blackmagic-design.TeranexMini",
              "com.blackmagic-design.TeranexUninstaller",
            ],
            delete:  "/Applications/Blackmagic Teranex"

  zap trash: "~/Library/Preferences/com.blackmagic-design.Teranex Setup.plist"
end
