cask "davinci-resolve-studio@beta" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "21.0.3,257ac6878ddf40dc8c8b72c3b65c0de3,795667a2eece4ba38ea424a861c3134f,"
  sha256 "5c591f8000f6ee12092e30954cc140cea60bae85f36d8e2625ff172ecd222526"

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
    "product"          => "Davinci Resolve",
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
  name "Davinci Resolve"
  desc "Video Editing Software"
  homepage "https://www.blackmagicdesign.com/au/products/davinciresolve/"

  livecheck do
    url "https://www.blackmagicdesign.com/api/support/us/downloads.json"
    strategy :json do |json|
      matched = json["downloads"].select do |download|
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "davinci-resolve-studio"
      end
      matched.map do |download|
        beta = /beta/i.match?(download["name"])
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]},#{"b" if beta}"
      end.first
    end
  end

  conflicts_with cask: "davinci-resolve-studio"
  depends_on macos: :sonoma

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
              "com.blackmagic-design.Manifest",
              "com.blackmagic-design.ManifestBlackmagicRawPlayer",
              "com.blackmagic-design.ManifestPanels",
            ]

  zap trash: [
    "~/Library/Application Scripts/com.blackmagic-design.DaVinciResolve",
    "~/Library/Application Support/Welcome to DaVinci Resolve",
    "~/Library/Containers/com.blackmagic-design.DaVinciResolve",
    "~/Library/Preferences/com.blackmagic-design.DaVinciResolve.plist",
    "~/Library/Saved Application State/com.blackmagic-design.DaVinciResolve.savedState",
  ]
end
