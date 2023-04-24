cask "gld-editor" do
  version "1.61"
  sha256 "bf099adfe233f6a8c1b199178e53fe2467282d5f1f45443a732e43798b805167"

  url "https://www.allen-heath.com/media/GLD-Editor-#{version}-Installer.dmg"
  name "Allen & Heath GLD Editor"
  desc "Software control for Allen & Heath GLD Series Audio Console"
  homepage "https://www.allen-heath.com/key-series/gld-series"

  livecheck do
    url :homepage
    regex(/GLD\s*Editor\s*v?(\d+(?:\.\d+)+)[< "]/i)
  end

  pkg "GLD Editor #{version} Installer.pkg"

  uninstall pkgutil: "com.allenheath.pkg.gldeditor*"

  zap trash: [
    "~/Library/Preferences/com.allen-heath.GLD Editor*.plist",
    "~/Library/Saved Application State/com.allenheath.gldeditor*.savedState",
  ]
end
