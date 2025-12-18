cask "qik" do
  version "1.1.1"
  sha256 "2b872c0f546c8cfde86dd5ae94609b0ee73e0a61d7d1252c997805f41691914c"

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
