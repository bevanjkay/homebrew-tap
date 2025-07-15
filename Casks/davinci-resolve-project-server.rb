cask "davinci-resolve-project-server" do
  require "#{HOMEBREW_TAP_DIRECTORY}/bevanjkay/homebrew-tap/cmd/lib/bmd_download_strategy"

  version "20.0.0,49,643b50e4081d4cc5895903b131ca5caf,"
  sha256 "b3d4a107c343217fab9a61cb61a320d7d6e9eae0c8936d95367f8866881ee3a9"

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
  name "Davinci Resolve Project Server"
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

      "#{version_info["major"]}.#{version_info["minor"]}.#{version_info["releaseNum"]},#{version_info["build"]},#{version_info["downloadId"]},#{"b" if version_info["beta"]}"
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  pkg "Install DaVinci Resolve Project Server #{version.csv.first.chomp(".0")}#{version.csv.fourth}.pkg"

  uninstall launchctl: "com.edb.launchd.postgresql-13",
            script:    {
              executable: "/Applications/DaVinci Resolve Project Server/Uninstall DaVinci Resolve Project Server.app/Contents/Resources/uninstall_projectserver.sh",
              sudo:       true,
            },
            pkgutil:   [
              "com.blackmagic-design.ManifestPostgres",
              "com.blackmagic-design.ManifestProjectServer",
            ]

  zap trash: "~/Library/Saved Application State/com.blackmagic-design.DaVinciResolveProjectServer.savedState"
end
