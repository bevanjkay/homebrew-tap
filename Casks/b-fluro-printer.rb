cask "b-fluro-printer" do
  version "6.2.4"
  sha256 "86a0587db197a0995524e0d456117f037d77e2404db470590bc221caa917b4b8"

  url "https://api.fluro.io/download/58afc74c7b3e1d3b73f7a949?version=#{version}"
  name "b-fluro-printer"
  desc "Fluro printer app"
  homepage "https://support.fluro.io/view/checkin-printer"

  livecheck do
    url "https://api.fluro.io/download/58afc74c7b3e1d3b73f7a949"
    strategy :header_match
  end

  pkg "Fluro%20Printer-#{version}.pkg"

  uninstall trash: "/Applications/Fluro Printer.app"

  zap trash: [
    "~/Library/Application Support/Fluro Printer",
    "~/Library/Logs/Fluro Printer",
    "~/Library/Preferences/io.fluro.printer.helper.plist",
    "~/Library/Preferences/io.fluro.printer.plist",
    "~/Library/Saved Application State/io.fluro.printer/savedState",
    "/var/db/receipts/io.fluro.printer.bom",
    "/var/db/receipts/io.fluro.printer.plist",
  ]
end
