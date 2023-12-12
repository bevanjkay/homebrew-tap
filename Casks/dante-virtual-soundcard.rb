cask "dante-virtual-soundcard" do
  version "4.4.1.3"
  sha256 "ff2b5384b4905ed479915e8d4f9a1220abc88a379a0e129d2f76c302c8e72a99"

  url "https://audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteVirtualSoundcard/#{version.major}/#{version.major_minor}/macOS/DVS-#{version}_macos.dmg",
      verified: "audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteVirtualSoundcard/"
  name "Dante Virtual Soundcard"
  desc "Virtual direct I/O for Dante Network"
  homepage "https://www.audinate.com/products/software/dante-virtual-soundcard"

  livecheck do
    url "https://audinate.jfrog.io/artifactory/ad8-software-updates-prod/DanteVirtualSoundcard/appcast/macOS/DanteVirtualSoundcard-macOS.xml"
    strategy :sparkle
  end

  auto_updates true

  pkg "DanteVirtualSoundcard.pkg"

  uninstall pkgutil:   [
              "com.audinate.dante.conmon.pkg",
              "com.audinate.dante.pkg.dvs.ui",
              "com.audinate.dante.pkg.dvs.DanteVirtualSoundcard",
            ],
            launchctl: [
              "com.audinate.dante.ConMon",
              "com.audinate.dante.DanteVirtualSoundcard",
            ]

  zap trash: [
    "/Library/LaunchDaemons/com.audinate.dante.ConMon.plist",
    "/Library/LaunchDaemons/com.audinate.dante.DanteVirtualSoundcard.plist",
    "/Library/Preferences/com.audinate.dante.install",
    "~/Library/Application Support/dante-software-license",
    "~/Library/Caches/dante-software-license",
    "~/Library/HTTPStorages/com.audinate.DanteVirtualSoundcard",
    "~/Library/Preferences/com.audinate.DanteVirtualSoundcard.plist",
    "~/Library/Saved Application State/com.audinate.DanteVirtualSoundcard.savedState",
  ]
end
