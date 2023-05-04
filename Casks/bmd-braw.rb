cask "bmd-braw" do
  require "net/http"

  version "3.0.0,41380dfdbea44513b3f251539e020ff2,b1743c35d18444fdafb39fdba1d1b374"
  sha256 "4b2f2611cebbec2a5740e9d99008a3bb7453a53e88bdd4592827f05944450a04"

  url do
    if File.exist?("#{Dir.home}/.personal_details.json")
      personal_details = JSON.parse(File.read("#{Dir.home}/.personal_details.json"))
    else
      opoo "Please create a personal details file at `~/.personal_details.json` - using placeholder data"
      personal_details = {
        "firstname"   => "Joe",
        "lastname"    => "Bloggs",
        "email"       => "testemail@gmail.com",
        "phone"       => "61412345678",
        "city"        => "Melbourne",
        "state"       => "Victoria",
        "countrycode" => "au",
      }
    end

    params = {
      "platform"         => "Mac OS X",
      "product"          => "Blackmagic RAW 3.0",
      "firstname"        => personal_details["firstname"],
      "lastname"         => personal_details["lastname"],
      "email"            => personal_details["email"],
      "phone"            => personal_details["phone"],
      "city"             => personal_details["city"],
      "state"            => personal_details["state"],
      "country"          => personal_details["countrycode"],
      "policy"           => "true",
      "hasAgreedToTerms" => "true",
    }.to_json

    uri = URI("https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}")
    resp = Net::HTTP.post(uri, params, { "Content-Type" => "application/json" })

    resp.body
  end
  name "Blackmagic Converters"
  desc "Utility to update and control Blackmagic Design Converters"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, _err, _st =
        Open3.capture3("curl -X POST -H \"Content-Type: application/json\" -d '{\"product\":\"braw-sdk\", " \
                       "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"")
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["releaseId"]},#{version_info["downloadId"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  container nested: "Blackmagic_RAW_#{version.csv.first.chomp(".0")}.dmg"

  pkg "Install Blackmagic RAW #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic RAW/Uninstall Blackmagic RAW.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.BlackmagicRawSDK",
              "com.blackmagic-design.BlackmagicRawUninstaller",
              "com.blackmagic-design.BlackmagicRaw",
            ]

  zap trash: [
    "~/Library/Application Scripts/com.blackmagic-design.BlackmagicRawPlayer",
    "~/Library/Containers/com.blackmagic-design.BlackmagicRawPlayer",
  ]
end
