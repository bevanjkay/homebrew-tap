cask "dante-virtual-soundcard" do
  arch arm: "-apple-silicon"

  on_arm do
    version "4.2.4.1"
    sha256 "fdf5fe25444aace7683bc486dfec7a3922445c9720b997331f4e980eadcbffd9"

    url "https://audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteVirtualSoundcard/#{version.major}/#{version.major_minor}/macOS/DVS-#{version}_macos#{arch}.dmg",
        verified: "audinate-software-updates.sgp1.digitaloceanspaces.com/DanteVirtualSoundcard/"

    livecheck do
      url "https://audinate.jfrog.io/artifactory/ad8-software-updates-prod/DanteVirtualSoundcard/appcast/macOS/DanteVirtualSoundcard-macOS.xml"
      strategy :sparkle
    end
  end
  on_intel do
    version "4.1.2.3"
    sha256 "edd61bc82c75205e2e311e60c666fe2c80b825a500efa2b4ce513f9ecb277b92"

    url "https://audinate-software-updates.sgp1.cdn.digitaloceanspaces.com/DanteVirtualSoundcard/#{version.major}/#{version.major_minor}/DVS-#{version}_macos#{arch}.dmg",
        verified: "audinate-software-updates.sgp1.digitaloceanspaces.com/DanteVirtualSoundcard/"

    livecheck do
      url "https://audinate.jfrog.io/artifactory/ad8-software-updates-prod/DanteVirtualSoundcard/appcast/DanteVirtualSoundcard-OSX.html"
      regex(/Dante\s*Virtual\s*Soundcard\s*v?(\d+(?:\.\d+)+)[< "]/i)
    end
  end

  name "Dante Virtual Soundcard"
  desc "Virtual direct I/O for Dante Network"
  homepage "https://www.audinate.com/products/software/dante-virtual-soundcard"

  auto_updates true

  pkg "DanteVirtualSoundcard.pkg"

  uninstall pkgutil: [
    "com.audinate.dante.conmon.pkg",
    "com.audinate.dante.pkg.dvs.ui",
    "com.audinate.dante.pkg.dvs.DanteVirtualSoundcard",
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
