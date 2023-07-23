cask "davinci-resolve-studio" do
  require "net/http"

  version "18.5.0,41,672870116b8c4bc9bd54498e9e1ab4b6,"
  sha256 "28214b394eac1c8de7a8b5c0bb5a03c771f58f15dbba5012857c7a010f64300f"

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
      "state"     => personal_details["state"],
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
    url "https://www.blackmagicdesign.com/"
    strategy :page_match do
      res, = Open3.capture3(
        "curl -X POST -H \"Content-Type: application/json\" -d '{\"product\": \"davinci-resolve-studio\", " \
        "\"platform\":\"mac\"}' \"https://www.blackmagicdesign.com/api/support/latest-version\"",
      )
      version_info = JSON.parse(res)["mac"]
      next if version_info.blank?

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["build"]},#{version_info["downloadId"]},#{version_info["beta"] ? "b" : ""}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Resolve #{version.csv.first}#{version.csv.fourth}.pkg"

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
              "com.blackmagic-design.ManifestPanels",
              "com.blackmagic-design.Manifest",
            ]

  zap trash: [
    "~/Library/Application Scripts/com.blackmagic-design.DaVinciResolve",
    "~/Library/Application Support/Welcome to DaVinci Resolve",
    "~/Library/Containers/com.blackmagic-design.DaVinciResolve",
    "~/Library/Preferences/com.blackmagic-design.DaVinciResolve.plist",
    "~/Library/Saved Application State/com.blackmagic-design.DaVinciResolve.savedState",
  ]
end
