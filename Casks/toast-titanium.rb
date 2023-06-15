cask "toast-titanium" do
  version "20.2"
  sha256 "8b8ffc642ae9ca595509f1e0735a5104d3d87cedfbf144002bf63b60c0c58b34"

  url "https://img.roxio.com/updaters/toast/v#{version.no_dots}/titanium/Toast_Titanium.zip"
  name "Toast Titanium"
  desc "DVD Burner"
  homepage "https://www.roxio.com/en/products/toast/titanium/"

  livecheck do
    url "https://www.corel.com/toast/toast20/titanium/appcast_toast_20.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true

  pkg "Toast #{version.major} Titanium.pkg"

  uninstall pkgutil: [
    "com.roxio.toast.toast#{version.major}Titanium.Akrilic.pkg",
    "com.roxio.toast.toast#{version.major}Titanium.MultiCamCaptureandEditing.pkg",
    "com.roxio.toast.toast#{version.major}Titanium.ToastSlice.pkg",
    "com.roxio.toast.toast#{version.major}Titanium.RoxioSecureBurn.pkg",
    "com.roxio.toast.toast#{version.major}Titanium.ToastAudioAssistant.pkg",
    "com.roxio.toast.toast#{version.major}Titanium.ScreenCapture.pkg",
    "com.roxio.toast.toast#{version.major}.DiskCatalogMaker.pkg",
    "com.roxio.toast.toast#{version.major}Titanium.ToastTitanium.pkg",
  ]

  zap trash: [
    "/Library/Application Support/Roxio",
    "~/Library/Application Support/Roxio",
    "~/Library/Caches/com.corel.ToastStub",
    "~/Library/Caches/com.roxio.Toast",
    "~/Library/HTTPStorages/com.corel.ToastStub",
    "~/Library/HTTPStorages/com.corel.ToastStub.binarycookies",
    "~/Library/HTTPStorages/com.roxio.Toast",
    "~/Library/HTTPStorages/com.roxio.Toast.binarycookies",
    "~/Library/Preferences/Roxio Toast Prefs",
    "~/Library/Preferences/com.roxio.Toast.plist",
    "~/Library/WebKit/com.roxio.Toast",
  ], rmdir: [
    "~/Documents/Roxio Captured Items",
    "~/Documents/Roxio Converted Items",
  ]
end
