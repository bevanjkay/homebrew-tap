cask "tallyarbiter" do
  version "3.1.1"
  sha256 "7100aa56714618c8efd4afbf93d732f89c59039eff6114a0ccfb13ef8878e7bc"

  url "https://github.com/josephdadams/TallyArbiter/releases/download/v#{version}/TallyArbiter-#{version}-arm64.dmg",
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
end
