cask "kiosk-browser" do
  version "0.17.0"
  sha256 "0d6fbbe22612862d37e8dc23a37907dc2645f042c14a2fae821bd45d866073ad"

  url "https://github.com/IMAGINARY/kiosk-browser/releases/download/v#{version}/kiosk-browser-#{version}.dmg"
  name "Kiosk Browser"
  desc "Web kiosk system"
  homepage "https://github.com/IMAGINARY/kiosk-browser"

  app "kiosk-browser.app"
  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/kiosk-browser-wrapper.sh"
  binary shimscript, target: "kiosk-browser"

  preflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      '#{appdir}/kiosk-browser.app/Contents/MacOS/kiosk-browser' "$@"
    EOS
  end

  postflight do
    system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/kiosk-browser.app"]
  end

  zap trash: [
    "~/Library/Application Support/kiosk-browser",
    "~/Library/Preferences/org.imaginary.kiosk.plist",
    "~/Library/Saved Application State/org.imaginary.kiosk.savedState",
  ]
end
