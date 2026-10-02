cask "davinci-resolve-studio" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "21.1.1,dfbb6e4233c144d1b328c109c7ebc11e,020785f9c8e54df5a1f50b8a1667f5d0"
  sha256 "25ac3f6b8e3eaa617d0a9451f651d2d41dc0799512156c664b55cbb1a7cff07d"

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
        next false if /beta/i.match?(download["name"])
        next false if download["urls"]["Mac OS X"].blank?

        download["urls"]["Mac OS X"].first["product"] == "davinci-resolve-studio"
      end
      matched.map do |download|
        v = download["urls"]["Mac OS X"].first
        "#{v["major"]}.#{v["minor"]}.#{v["releaseNum"]},#{v["releaseId"]},#{v["downloadId"]}"
      end
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  conflicts_with cask: "davinci-resolve-studio@beta"
  depends_on macos: :sequoia

  pkg "Install Resolve #{version.csv.first.chomp(".0")}.pkg"

  uninstall launchctl: "com.blackmagic-design.DaVinciResolveBMDPanelDaemon",
            pkgutil:   [
              "com.blackmagic-design.BlackmagicRaw_resolve",
              "com.blackmagic-design.DaVinciKeyboards",
              "com.blackmagic-design.DaVinciPanels",
              "com.blackmagic-design.FairlightPanels",
              "com.blackmagic-design.Manifest",
              "com.blackmagic-design.ManifestBlackmagicRawPlayer",
              "com.blackmagic-design.ManifestPanels",
            ],
            delete:    [
              "/Applications/DaVinci Resolve",
              "/Library/Application Support/Blackmagic Design/DaVinci Resolve Advanced Panel",
              "/Library/Application Support/Blackmagic Design/DaVinci Resolve Panels/AdminUtility",
              "/Library/Frameworks/DaVinciPanelAPI.framework",
              "/Library/Frameworks/FairlightPanelAPI.framework",
              "/Library/OFX/Plugins/DaVinci Resolve Renderer.ofx.bundle",
              "/var/tmp/davinci_socket",
            ],
            rmdir:     "/Library/Application Support/Blackmagic Design/DaVinci Resolve Panels"

  zap trash: [
    "~/Library/Application Scripts/com.blackmagic-design.DaVinciResolve",
    "~/Library/Application Support/Welcome to DaVinci Resolve",
    "~/Library/Containers/com.blackmagic-design.DaVinciResolve",
    "~/Library/Preferences/com.blackmagic-design.DaVinciResolve.plist",
    "~/Library/Saved Application State/com.blackmagic-design.DaVinciResolve.savedState",
  ]
end
