cask "ndi-core-suite" do
  version "5.6"
  sha256 :no_check

  url "https://downloads.ndi.tv/Tools/NDIToolsInstaller.pkg",
      verified: "downloads.ndi.tv/Tools/"
  name "NDI Core Suite"
  desc "Tools & plugins for NDI"
  homepage "https://ndi.video/tools/ndi-core-suite/"

  # TODO: https://downloads.ndi.video/Tools/ndi_tools_osx_current_version.json
  livecheck do
    url :homepage
    regex(/Version\s*number:\s*v?(\d+(?:\.\d+)+)/i)
  end

  pkg "NDIToolsInstaller.pkg"

  uninstall launchctl: "com.newtek.cmio.DPA.NDI",
            pkgutil:   [
              "com.newtek.Application-Mac-NDI-AccessManager",
              "com.newtek.Application-Mac-NDI-ScanConverter",
              "com.newtek.Application-Mac-NDI-StudioMonitor",
              "com.newtek.Application-Mac-NDI-VirtualInput",
              "com.newtek.DAL.NDIplugin",
              "com.newtek.DAL.NDIpluginlaunchdaemon",
              "com.newtek.driver.NDIAudio",
              "com.newtek.HAL.NDIaudioplugin",
              "com.newtek.NDI-HX-Driver",
              "com.newtek.NDI-Tools",
              "com.newtek.NDI-Transmit-AdobeCC",
              "com.newtek.NDI.prefpane",
              "com.newtek.ndi.recording",
              "com.newtek.NDIVirtualCamera",
              "com.newtek.NewTek-Import-SpeedHQ",
              "com.newtek.Test-Patterns-Mac-",
            ]

  zap trash: [
    "/Library/Application Support/NewTek",
    "/Library/LaunchDaemons/com.newtek.cmio.DPA.NDI.plist",
    "~/Library/Caches/com.newtek.NDI-Tools",
    "~/Library/Preferences/com.newtek.Application-Mac-NDI-ScanConverter.plist",
    "~/Library/Preferences/com.newtek.Application-Mac-NDI-StudioMonitor.plist",
    "~/Library/Preferences/com.newtek.NDI-Tools.plist",
    "~/Library/Preferences/com.newtek.Test-Patterns-Mac-.plist",
    "~/Library/WebKit/com.newtek.NDI-Tools",
  ]
end
