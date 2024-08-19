cask "kiosk-browser" do
  version "0.18.0"
  sha256 "5616873915d6420230ea4dc9875ce6bd4f9e589519c64d791a2bb379bdc88010"

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

  caveats do
    requires_rosetta
  end
end
