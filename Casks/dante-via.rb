cask "dante-via" do
  version "1.3.1.3"
  sha256 "9fee1a9241a9a3a502e41b0f2f89a3046ed009a3831a63eb91efa1144d2a434c"

  url "https://audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteVia/#{version.major}/#{version.major_minor}/DanteVia-#{version}_macos.dmg"
  name "Dante Via"
  desc "Connect application to Dante network"
  homepage "https://www.audinate.com/products/software/dante-via"

  livecheck do
    url "https://audinate.jfrog.io/artifactory/ad8-software-updates-prod/DanteVia/appcast/DanteVia-OSX.xml"
    strategy :sparkle
  end

  pkg "Dante Via.pkg"

  uninstall pkgutil: [
    "com.audinate.dante.conmon.pkg",
    "com.audinate.dante.pkg.DanteVia",
  ]
end
