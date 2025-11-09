cask "piano-trainer" do
  version "1.3.2"
  sha256 "99284a001e9001e618f04149b46d0bdf65f1f318ef1df531cd18f3e2bdb4993f"

  url "https://github.com/ZaneH/piano-trainer/releases/download/app-v#{version}/Piano.Trainer_#{version}_x64.dmg",
      verified: "github.com/ZaneH/piano-trainer/"
  name "Piano Trainer"
  desc "Piano learning application"
  homepage "https://zaneh.itch.io/piano-trainer"

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
