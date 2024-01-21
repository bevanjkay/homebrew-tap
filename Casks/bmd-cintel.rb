cask "bmd-cintel" do
  require "net/http"

  version "5.0.0,11a3ba20ff104be192e523725ded5625,2b2893eb27834d93a74cbb683e16a25a"
  sha256 "1b0d85ecb482f07776a3e48daa9bc531517b630acbe3c156635fa74c912df993"

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
  container nested: "Blackmagic_Cintel_#{version.csv.first.chomp(".0")}.dmg"

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
