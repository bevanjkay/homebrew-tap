cask "gld-editor" do
  version "1.61,2023,06"
  sha256 "7e7902447b686950167c134680d16dcdab697412a8855ad54a9a844e5e6cd834"

  url "https://www.allen-heath.com/content/uploads/#{version.csv.second}/#{version.csv.third}/GLD-Editor-#{version.csv.first}-Installer-Mac.zip",
      user_agent: :fake
  name "Allen & Heath GLD Editor"
  desc "Software control for Allen & Heath GLD Series Audio Console"
  homepage "https://www.allen-heath.com/hardware/legacy-products/gld-80/"

  livecheck do
    url "https://www.allen-heath.com/hardware/legacy-products/gld-80/resources/"
    regex(%r{href=.*?/([^/]+)/([^/]+)/GLD-Editor[._-]v?(\d+(?:\.\d+)+)[._-]Installer[._-]Mac\.zip}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match.third},#{match.first},#{match.second}" }
    end
  end

  pkg "GLD Editor #{version.csv.first} Installer.pkg"

  uninstall pkgutil: "com.allenheath.pkg.gldeditor*"

  zap trash: [
    "~/Library/Preferences/com.allen-heath.GLD Editor*.plist",
    "~/Library/Saved Application State/com.allenheath.gldeditor*.savedState",
  ]
end
