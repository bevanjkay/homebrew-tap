cask "kiosk-browser-settings" do
  version "20230227"
  sha256 :no_check

  url "https://gc.org.au/app/kiosk-settings/kiosk-settings.zip"
  name "Kiosk Browser Settings"
  desc "Settings for Web Kiosk Browser"
  homepage "https://gc.org.au"

  depends_on cask: "bevanjkay/tap/kiosk-browser"

  artifact "hub.command", target: "~/Desktop/Kiosk Browser Commands/hub.command"
  artifact "youth.command", target: "~/Desktop/Kiosk Browser Commands//youth.command"
  artifact "website.command", target: "~/Desktop/Kiosk Browser Commands/website.command"
  artifact "missions-signage.command", target: "~/Desktop/Kiosk Browser Commands/missions-signage.command"
  artifact "giving-kiosk.command", target: "~/Desktop/Kiosk Browser Commands/giving-kiosk.command"

  postflight do
    files = system_command "/bin/ls", args: ["#{staged_path}"]
    files_list = files.stdout.split("\n")
    files_list.each do |file|
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{staged_path}/#{file}"]
      system_command "/bin/chmod", args: ["+x", "#{staged_path}/#{file}"]
    end
  end

  uninstall trash: "~/Desktop/Kiosk Browser Commands"
end
