cask "gateway-printer-driver" do
  version "7.115.0.0,19994"
  sha256 "3ddeb27eabb6e3ae83cd24c78108b97487e4d169291834a98a08837d6e94bdd3"

  url "https://business.toshiba.com/downloads/KB/f1Ulds/#{version.csv.second}/TOSHIBA_ColorMFP.dmg.gz"
  name "Toshiba ColorMFP Drivers"
  desc "Drivers for Toshiba ColorMFP devices"
  homepage "https://business.toshiba.com/support"

  livecheck do
    url "https://business.toshiba.com/support/downloads/GetDownloads.jsp?model=e-STUDIO3515AC"
    strategy :page_match do |page|
      match = page.match(/"TOSHIBA_ColorMFP.dmg.gz",.*?"id":"(\d+)",.*?"versionName":"(\d+(?:\.\d+)+)",/)
      next if match.blank?

      "#{match[2]},#{match[1]}"
    end
  end

  conflicts_with cask: "toshiba-color-mfp"

  pkg "TOSHIBA ColorMFP.pkg"

  uninstall pkgutil: "com.toshiba.pde.x7.colormfp",
            delete:  [
              "/Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP*.gz",
              "/Library/Printers/toshiba",
            ]
end
