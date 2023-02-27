cask "kiosk-browser" do
  version "0.17.0"
  sha256 "0d6fbbe22612862d37e8dc23a37907dc2645f042c14a2fae821bd45d866073ad"

  url "https://github.com/IMAGINARY/kiosk-browser/releases/download/v#{version}/kiosk-browser-#{version}.dmg"
  name "Kiosk Browser"
  desc "Web kiosk system"
  homepage "https://github.com/IMAGINARY/kiosk-browser"

  app "kiosk-browser.app"
  binary "#{appdir}/kiosk-browser.app/Contents/MacOS/kiosk-browser", target: "kiosk-browser"

  zap trash: [
    "~/Library/Application Support/kiosk-browser",
    "~/Library/Preferences/org.imaginary.kiosk.plist",
    "~/Library/Saved Application State/org.imaginary.kiosk.savedState",
  ]
end
