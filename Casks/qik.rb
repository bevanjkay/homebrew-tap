cask "qik" do
  version "1.2.1"
  sha256 "b13717d46ca2fbfc862f65fa80fa59c09eaa1142b1bc6ff97822724e93f2daac"

  url "https://github.com/bevanjkay/pake-builder/releases/download/qik-#{version}/Qik.dmg"
  name "Qik"
  desc "Desktop application for Qik"
  homepage "https://qik.dev/"

  livecheck do
    url :url
    regex(/qik[._-]v?(\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  app "Qik.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/Qik.app"], must_succeed: false
  end

  zap trash: "~/Library/Application Support/Qik"
end
