cask "bmd-fairlight-live" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "1.1.0,cde56ff586c5480ca21eed384c9b20ce,8492d7b0771042b18bd7ffdf8c98c8de"
  sha256 "7d5bde3eaf95cfa511c398e3d51f10e9078a46684ffb1320a977d0800e704359"

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
    "product"          => "Fairlight Live",
    "firstname"        => personal_details["firstname"],
    "lastname"         => personal_details["lastname"],
    "email"            => personal_details["email"],
    "phone"            => personal_details["phone"],
    "street"           => personal_details["address"],
    "city"             => personal_details["city"],
    "state"            => personal_details["state"],
    "zip"              => personal_details["zip"],
    "country"          => personal_details["countrycode"],
    "policy"           => true,
    "hasAgreedToTerms" => true,
  }

  url "https://www.blackmagicdesign.com/api/register/us/download/#{version.csv.third}",
      using: BmdDownloadStrategy,
      data:  params
  name "Fairlight Live"
  name "Blackmagic Fairlight Live"
  desc "Audio mixer for broadcast and live events"
  homepage "https://www.blackmagicdesign.com/au/products/fairlightlive/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "fairlight-live"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  depends_on macos: :sonoma

  pkg "Install Fairlight Live #{version.csv.first.chomp(".0")}.pkg"

  uninstall script:  {
              executable: "/Applications/Fairlight Live/Uninstall Fairlight Live.app/Contents/Resources/uninstall_fairlightlive.sh",
              sudo:       true,
            },
            pkgutil: [
              "com.blackmagic-design.FairlightLive",
              "com.blackmagic-design.ManifestFairlightLive",
              "com.blackmagic-design.ManifestPanelsFairlightLive",
            ]

  zap trash: [
    "~/Library/Application Support/Blackmagic Design/Fairlight Live",
    "~/Library/Preferences/Blackmagic Design/Fairlight Live",
    "~/Library/Saved Application State/com.blackmagic-design.BlackmagicFairlightLive.savedState",
  ]
end
