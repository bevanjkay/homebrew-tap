cask "piano-trainer" do
  version "1.3.1"
  sha256 "5c52262bec558cb15dc88bd9eec3f1b8cd1564fdb9920829f9e43ffbabfdae0f"

  url "https://github.com/ZaneH/piano-trainer/releases/download/app-v#{version}/Piano.Trainer_#{version}_x64.dmg",
      verified: "github.com/ZaneH/piano-trainer/"
  name "Piano Trainer"
  desc "Piano learning application"
  homepage "https://zaneh.itch.io/piano-trainer"

  depends_on macos: ">= :high_sierra"

  app "Piano Trainer.app"

  zap trash: [
    "~/Library/Application Support/com.zane.piano-trainer",
    "~/Library/Caches/com.zane.piano-trainer",
    "~/Library/WebKit/com.zane.piano-trainer",
  ]

  caveats do
    requires_rosetta
  end
end
