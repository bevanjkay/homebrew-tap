cask "kiosk-browser" do
  version "0.18.1"
  sha256 "1e4f97d3eeaa7f7099d99d7bb1adaf41effac9ea34a6cc5a59ea5436cbcdced1"

  url "https://github.com/IMAGINARY/kiosk-browser/releases/download/v#{version}/kioskY-browser-#{version}.dmg"
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

  zap trash: [
    "~/Library/Application Support/kiosk-browser",
    "~/Library/Preferences/org.imaginary.kiosk.plist",
    "~/Library/Saved Application State/org.imaginary.kiosk.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
