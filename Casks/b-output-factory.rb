cask "b-output-factory" do
  version "2.4.78"
  sha256 :no_check

  url "https://zevrix.com/downloads/OutputFactory.dmg"
  name "Output Factory"
  desc "Automate printing and exporting from Adobe InDesign"
  homepage "https://zevrix.com/OutputFactory/"

  livecheck do
    url "https://zevrix.com/download/"
    regex(/Output\s*Factory\s*(\d+(?:\.\d+)+)/i)
  end

  app "Output Factory Installer.app"

  postflight do
    system "open", "/Applications/Output Factory Installer.app"
    system "sleep", "10"
    system "rm -rf", "/Applications/Output Factory Installer.app"
  end

  uninstall trash: "/Applications/Adobe Indesign */Plug-Ins/Zevrix/Output Factory.app"

  zap trash: [
    "~/Library/Caches/com.zevrix.OutputFactory",
    "~/Library/Preferences/com.zevrix.OutputFactory.plist",
  ]
end
