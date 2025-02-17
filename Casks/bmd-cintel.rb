cask "bmd-cintel" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "6.1.0,ffae80f0d41947debae40cbd300b54b5,83c36d7b04144b8996338380473c3998"
  sha256 "cfd382dff86244f0ceb29a5ad4acedc1b06297d3c710588d1d5ecfea72514f40"

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  {
        "platform"     => "Mac OS X",
        "downloadOnly" => "true",
        "country"      => "us",
        "policy"       => "true",
      }
  name "Blackmagic Cintel"
  desc "Update and manage Blackmagic Cintel Scanner Hardware"
  homepage "https://www.blackmagicdesign.com/products/cintel"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "cintel"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Cintel #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Cintel/Uninstall Cintel.app/Contents/Resources/uninstall.sh",
              sudo:       true,
              args:       ["--path", "/Applications/Blackmagic Cintel/Uninstall Cintel.app/Contents/Resources"],
            },
            pkgutil: [
              "com.blackmagic-design.Cintel",
              "com.blackmagic-design.CintelAssets",
              "com.blackmagic-design.CintelUninstaller",
            ]

  zap trash: [
    "/Library/PreferencePanes/Blackmagic Cintel.prefPane",
    "~/Library/Preferences/com.blackmagic-design.Cintel Setup.plist",
  ]
end
