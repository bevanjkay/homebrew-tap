cask "davinci-resolve@beta" do
  require "net/http"

  version "19.0.0,c3135f5e36144d268c71e104cfc32a82,9d2321946dd74ccfa52391df79f5129a,b"
  sha256 "e999b1b6cc89b3db1798ea8c4b95c9632f2b5e740f1beb49b358593f63a3c85f"

  url do
    if File.exist?("#{Dir.home}/.personal_details.json")
      personal_details = JSON.parse(File.read("#{Dir.home}/.personal_details.json"))
    else
      opoo "Please create a personal details file at `~/.personal_details.json` - using placeholder data"
      personal_details = {
        "firstname"   => "Joe",
        "lastname"    => "Bloggs",
        "email"       => "email@example.com",
        "phone"       => "61412345678",
        "address"     => "123 Main Street",
        "city"        => "Melbourne",
        "state"       => "Victoria",
        "zip"         => "3000",
        "countrycode" => "au",
      }
    end

    params = {
      "platform"  => "Mac OS X",
      "product"   => "DaVinci Resolve",
      "firstname" => personal_details["firstname"],
      "lastname"  => personal_details["lastname"],
      "email"     => personal_details["email"],
      "phone"     => personal_details["phone"],
      "city"      => personal_details["city"],
      "street"    => personal_details["address"],
      "state"     => personal_details["state"],
      "zip"       => personal_details["postcode"],
      "country"   => personal_details["countrycode"],
      "policy"    => "true",
    }.to_json

    uri = URI("https://www.blackmagicdesign.com/api/register/au/download/#{version.csv.third}")
    resp = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })

    resp.body
  end
  name "Davinci Resolve"
  desc "Video Editing Software"
  homepage "https://www.blackmagicdesign.com/au/products/davinciresolve/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "davinci-resolve"
      end
      matched.map do |download|
        beta = /beta/i.match?(download["name"])
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]},#{beta ? "b" : ""}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  conflicts_with cask: "davinci-resolve"

  pkg "Install Resolve #{version.csv.first.chomp(".0")}#{version.csv.fourth}.pkg"

  uninstall script:  {
              executable: "/Applications/DaVinci Resolve/Uninstall Resolve.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.BlackmagicRaw_resolve",
              "com.blackmagic-design.DaVinciKeyboards",
              "com.blackmagic-design.DaVinciPanels",
              "com.blackmagic-design.FairlightPanels",
              "com.blackmagic-design.ManifestBlackmagicRawPlayer",
              "com.blackmagic-design.ManifestLite",
              "com.blackmagic-design.ManifestPanels",
            ]

  zap trash: [
    "~/Library/Application Scripts/com.blackmagic-design.DaVinciResolveLite",
    "~/Library/Containers/com.blackmagic-design.DaVinciResolveLite",
    "~/Library/Saved Application State/com.blackmagic-design.DaVinciResolveLite.savedState",
  ]
end
