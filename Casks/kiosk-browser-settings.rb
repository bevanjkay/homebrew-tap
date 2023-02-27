cask "kiosk-browser-settings" do
  version :latest
  sha256 :no_check

  url "https://gc.org.au/app/kiosk-settings/kiosk-settings.zip"
  name "Kiosk Browser Settings"
  desc "Settings for Web Kiosk Browser"
  homepage "https://gc.org.au"

  depends_on cask: "bevanjkay/tap/kiosk-browser"

  artifact "hub.sh", target: "~/Desktop/hub.sh"
  artifact "giving-kiosk.sh", target: "~/Desktop/giving-kiosk.sh"
  artifact "youth.sh", target: "~/Desktop/youth.sh"
  artifact "website.sh", target: "~/Desktop/website.sh"
  artifact "missions-signage.sh", target: "~/Desktop/missions-signage.sh"
end
