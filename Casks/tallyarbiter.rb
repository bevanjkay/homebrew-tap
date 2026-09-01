cask "tallyarbiter" do
  arch arm: "arm64", intel: "x64"

  version "3.3.0"
  sha256 arm:   "a49592a551ce8cd100021eb4b89365953e5f9af71fff51f6c8310280356639cf",
         intel: "dd0e31111f4dc97a3f5cc96c85d02803d9164ebbfeb56b622d6750b7bf604094"

  url "https://github.com/josephdadams/TallyArbiter/releases/download/v#{version}/tallyarbiter-v#{version}-mac-#{arch}.dmg"
  name "TallyArbiter"
  desc "Camera tally light system"
  homepage "https://www.tallyarbiter.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

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
