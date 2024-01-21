cask "bmd-hyperdeck" do
  require "net/http"

  version "8.3.2,015997dc8024430a8678952bc58f8210,b5c741c3213348e1acec5ba28db650ec"
  sha256 "bd3c2d63bbde25eb83d80e95cfc1d51752acde6d66ba21710a23df375061d1f1"

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
  container nested: "Blackmagic_HyperDeck_#{version.csv.first.chomp(".0")}.dmg"

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
