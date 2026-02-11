cask "tallyarbiter" do
  arch arm: "arm64", intel: "x64"

  version "3.2.0"
  sha256 arm:   "4740e2fba9d6971db3083a08351c86fc157781ad78d077e8c7cc7c5212ef170b",
         intel: "cf8b7cdc43f9b964beec12b4f9b02c7f611d75fd33b7e522c972bf5e630d00ec"

  url "https://github.com/josephdadams/TallyArbiter/releases/download/v#{version}/tallyarbiter-v#{version}-mac-#{arch}.dmg",
      verified: "github.com/josephdadams/TallyArbiter/"
  name "TallyArbiter"
  desc "Camera tally light system"
  homepage "https://www.tallyarbiter.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Tally Arbiter.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "/Applications/Tally Arbiter.app"
  end

  zap trash: [
    "~/Library/Application Support/tallyarbiter",
    "~/Library/Preferences/com.electron.tallyarbiter.plist",
    "~/Library/Preferences/TallyArbiter",
  ]
end
