cask "kiosk-browser-settings" do
  version "20230303.5"
  sha256 :no_check

  url "https://gc.org.au/app/kiosk-settings/kiosk-settings.zip"
  name "Kiosk Browser Settings"
  desc "Settings for Web Kiosk Browser"
  homepage "https://gc.org.au/"

  livecheck do
    skip "Manual version management"
  end

  depends_on cask: "bevanjkay/tap/kiosk-browser"

  app "Start Hub.app", target: "~/Desktop/Kiosk Browser Commands/Start Hub.app"
  artifact "hub.command", target: "~/Desktop/Kiosk Browser Commands/hub.command"
  artifact "youth.command", target: "~/Desktop/Kiosk Browser Commands/youth.command"
  artifact "website.command", target: "~/Desktop/Kiosk Browser Commands/website.command"
  artifact "missions-signage.command", target: "~/Desktop/Kiosk Browser Commands/missions-signage.command"
  artifact "giving-kiosk.command", target: "~/Desktop/Kiosk Browser Commands/giving-kiosk.command"
  artifact "hubInject.js", target: "~/Desktop/Kiosk Browser Commands/hubInject.js"
  artifact "youthInject.js", target: "~/Desktop/Kiosk Browser Commands/youthInject.js"

  postflight do
    files = system_command "/bin/ls", args: [staged_path.to_s]
    files_list = files.stdout.split("\n")
    files_list.each do |file|
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{staged_path}/#{file}"]
      system_command "/bin/chmod", args: ["+x", "#{staged_path}/#{file}"]
    end
  end

  uninstall rmdir: "~/Desktop/Kiosk Browser Commands"
end
