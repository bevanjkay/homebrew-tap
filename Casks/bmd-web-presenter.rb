cask "bmd-web-presenter" do
  require "net/http"

  version "3.4.0,749a7d93d702481dbc51b682ae10c2ec,9bad309132e54dceadf1bf9466005d3a"
  sha256 "3bf25453191e9a6d9578086894f28a339d8514bc2b278dcb07ddd7bb0b2bfa91"

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
  name "Blackmagic Web Presenter"
  desc "Update and manage Blackmagic Web Presenter Hardware"
  homepage "https://www.blackmagicdesign.com/products/blackmagicwebpresenter"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "web-presenter"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_Web_Presenter_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Web Presenter #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic Web Presenter/Uninstall Web Presenter.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.WebPresenterUninstaller",
              "com.blackmagic-design.WebPresenterAssets",
              "com.blackmagic-design.WebPresenter",
            ]

  zap trash: "~/Library/Preferences/com.blackmagic-design.Web Presenter Setup.plist"
end
