cask "dante-controller" do
  version "4.10.0.3"
  sha256 "04852f88bf143c3c1abacc89ffff6a250d02fead5631a6a3263abad82fc94632"

  url "https://audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteController/#{version.major}/#{version.major_minor}/DanteController-#{version}_macos.dmg",
      verified: "audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteController/"
  name "Dante Controller"
  desc "Control inputs and outputs on a Dante network"
  homepage "https://www.audinate.com/products/software/dante-controller"

  livecheck do
    url "https://audinate.jfrog.io/artifactory/ad8-software-updates-prod/DanteController/appcast/DanteController-OSX.xml"
    strategy :sparkle
  end

  pkg "DanteController.pkg"

  uninstall pkgutil: [
    "com.audinate.dante.pkg.DanteController",
    "com.audinate.dante.pkg.DanteControllerPackage",
    "com.audinate.dante.conmon.pkg",
    "com.audinate.dante.pkg.DanteUpdateHelper",
    "com.audinate.dante.pkg.DanteUpdateHelperDB",
    "com.audinate.dante.pkg.DanteUpdater",
  ], launchctl: [
    "com.audinate.dante.ConMon",
    "com.audinate.dante.DanteUpdateHelper",
  ]

  zap trash: [
    "~/Library/Application Support/Dante Controller",
    "~/Library/Preferences/com.audinate.dante.controller.plist",
    "~/Library/Saved Application State/com.audinate.dante.DanteController.savedState",
  ]
end
