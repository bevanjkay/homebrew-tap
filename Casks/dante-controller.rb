cask "dante-controller" do
  version "4.9.0.8"
  sha256 "dd8d85f259580cc4a7320f660d501783e2bda15b6e03dbfd8c52f7ce88c5777d"

  url "https://audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteController/#{version.major}/#{version.major_minor}/DanteController-#{version}_macos.dmg",
      verified: "audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteController/"
  name "Dante Controller"
  desc "Control inputs and outputs on a Dante network"
  homepage "https://www.audinate.com/products/software/dante-controller"

  livecheck do
    url "https://audinate.jfrog.io/artifactory/ad8-software-updates-prod/DanteController/appcast/DanteController-OSX.xml"
    strategy :sparkle
  end

  pkg "Dante Controller.pkg"

  uninstall pkgutil: [
    "com.audinate.dante.pkg.DanteController",
    "com.audinate.dante.pkg.DanteControllerPackage",
  ]

  zap trash: [
    "~/Library/Application Support/Dante Controller",
    "~/Library/Preferences/com.audinate.dante.controller.plist",
    "~/Library/Saved Application State/com.audinate.dante.DanteController.savedState",
  ]
end
