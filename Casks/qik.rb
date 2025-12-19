cask "qik" do
  version "1.2.1"
  sha256 "b13717d46ca2fbfc862f65fa80fa59c09eaa1142b1bc6ff97822724e93f2daac"

  url "https://github.com/bevanjkay/pake-builder/releases/download/qik-#{version}/Qik.dmg",
      verified: "github.com/bevanjkay/pake-builder/"
  name "Qik"
  desc "Desktop application for Qik"
  homepage "https://qik.dev/"

  livecheck do
    url :url
    regex(/qik[._-]v?(\d+(?:\.\d+)+)/i)
  end

  app "Qik.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/Qik.app"
  end

  zap trash: "~/Library/Application Support/Qik"
end
