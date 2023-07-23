cask "davinci-resolve-project-server" do
  require "net/http"

  version "18.5.0,41,4904400144ca40d7a51a88420bfb43e8,"
  sha256 "528b440f87a9845cb9683600e4bae8be91a9d3c6274c8c43e56ff2f4a2a0eb01"

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
      "street"    => personal_details["address"],
      "city"      => personal_details["city"],
      "state"     => personal_details["state"],
      "zip"       => personal_details["postcode"],
      "country"   => personal_details["countrycode"],
      "policy"    => true,
    }.to_json

    uri = URI("https://www.blackmagicdesign.com/api/register/au/download/#{version.csv.third}")
    resp = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })

    resp.body
  end
  name "Davinci Resolve"
  desc "Video Editing Software"
  homepage "https://www.blackmagicdesign.com/au/products/davinciresolve/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, = Open3.capture3(
        "curl -X POST -H \"Content-Type: application/json\" -d '{\"product\": \"davinci-resolve-project-server\", " \
        "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"",
      )
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["build"]},#{version_info["downloadId"]},#{version_info["beta"] ? "b" : ""}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install DaVinci Resolve Project Server #{version.csv.first}#{version.csv.fourth}.pkg"

  uninstall script:    {
              executable: "/Applications/DaVinci Resolve Project Server/Uninstall DaVinci Resolve Project Server.app/Contents/Resources/uninstall_projectserver.sh",
              sudo:       true,
            },
            launchctl: "com.edb.launchd.postgresql-13",
            pkgutil:   [
              "com.blackmagic-design.ManifestPostgres",
              "com.blackmagic-design.ManifestProjectServer",
            ]

  zap trash: "~/Library/Saved Application State/com.blackmagic-design.DaVinciResolveProjectServer.savedState"
end
