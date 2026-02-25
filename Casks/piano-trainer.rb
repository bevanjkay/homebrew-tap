cask "piano-trainer" do
  version "1.3.3"
  sha256 "3a41ea5c8da152984397531dbc0b25d3610c9137b32245d48b0eddb79bb09448"

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
