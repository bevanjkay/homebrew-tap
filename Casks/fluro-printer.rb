cask "fluro-printer" do
  version "7.0.0"
  sha256 "0140f1c72e98490e8eef0a6022f95baa8d203469775dbd6aecf8752bdc3c1c6c"

  url "https://api.fluro.io/download/58afc74c7b3e1d3b73f7a949?version=#{version}"
  name "Fluro Printer"
  desc "Application for printing Fluro check-in labels"
  homepage "https://support.fluro.io/view/checkin-printer"

  livecheck do
    url "https://api.fluro.io/download/58afc74c7b3e1d3b73f7a949"
    strategy :header_match
  end

  pkg "Fluro%20Printer-#{version}.pkg"

  uninstall pkgutil: "io.fluro.printer",
            trash:   "/Applications/Fluro Printer.app"

  zap trash: [
    "~/Library/Application Support/Fluro Printer",
    "~/Library/Logs/Fluro Printer",
    "~/Library/Preferences/io.fluro.printer.helper.plist",
    "~/Library/Preferences/io.fluro.printer.plist",
    "~/Library/Saved Application State/io.fluro.printer/savedState",
  ]
end
