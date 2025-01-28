cask "bmd-braw" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "4.4.0,bda0b7ec70014f6b83d0289f974a87a6,63ab22dbafc4411dad5d40bb5d788302"
  sha256 "154ecafe40cf96f4a52c9ec38641a31a8c84aa0569559584349cdbdec4fb5c04"

  personal_details = if File.exist?("#{Dir.home}/.personal_details.json")
    JSON.parse(File.read("#{Dir.home}/.personal_details.json"))
  else
    {
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
  }

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  params
  name "Blackmagic Converters"
  desc "Utility to update and control Blackmagic Design Converters"
  homepage "https://www.blackmagicdesign.com/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "braw-sdk"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install Blackmagic RAW #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Blackmagic RAW/Uninstall Blackmagic RAW.app/Contents/Resources/uninstall.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.BlackmagicRaw",
              "com.blackmagic-design.BlackmagicRawSDK",
              "com.blackmagic-design.BlackmagicRawUninstaller",
            ]

  zap trash: [
    "~/Library/Application Scripts/com.blackmagic-design.BlackmagicRawPlayer",
    "~/Library/Containers/com.blackmagic-design.BlackmagicRawPlayer",
  ]
end
