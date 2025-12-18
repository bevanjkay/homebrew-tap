cask "qik" do
  version "1.0.0"
  sha256 "ec46018e9c3115a1d2ecf4cf73ca51ab0e618cedece5d7c878a32ea20c9ab14a"

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
