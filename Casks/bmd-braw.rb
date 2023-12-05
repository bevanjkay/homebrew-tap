cask "bmd-braw" do
  require "net/http"

  version "3.6.0,0efad310590a4999b4238371607878e4,3c35b056b3724ccabd32ef129dbc73e7"
  sha256 "37bf9cbc4fe32c76cc2c1c48c91203f54da094c4994473e09cc880df08e69ffa"

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
      "platform"         => "Mac OS X",
      "product"          => "Blackmagic RAW 3.0",
      "firstname"        => personal_details["firstname"],
      "lastname"         => personal_details["lastname"],
      "email"            => personal_details["email"],
      "phone"            => personal_details["phone"],
      "street"           => personal_details["address"],
      "city"             => personal_details["city"],
      "state"            => personal_details["state"],
      "zip"              => personal_details["postcode"],
      "country"          => personal_details["countrycode"],
      "policy"           => true,
      "hasAgreedToTerms" => true,
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
