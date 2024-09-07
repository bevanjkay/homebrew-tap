cask "tallyarbiter" do
  version "3.0.10"
  sha256 "9d5f39fffe2e0127a5608f8beccc40a83811b1d995b127199429d13f1bc34b81"

  url "https://github.com/josephdadams/TallyArbiter/releases/download/v#{version}/TallyArbiter-#{version}.dmg",
      verified: "github.com/josephdadams/TallyArbiter/"
  name "TallyArbiter"
  desc "Camera tally light system"
  homepage "https://www.tallyarbiter.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :catalina"

  app "TallyArbiter.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "/Applications/TallyArbiter.app"
  end

  zap trash: [
    "~/Library/Application Support/tallyarbiter",
    "~/Library/Preferences/com.electron.tallyarbiter.plist",
    "~/Library/Preferences/TallyArbiter",
  ]

  caveats do
    requires_rosetta
  end
end
