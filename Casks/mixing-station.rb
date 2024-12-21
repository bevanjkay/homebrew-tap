cask "mixing-station" do
  version "2.2.0"
  sha256 :no_check

  url "https://mixingstation.app/backend/api/web/download/attachment/mixing-station-pc/release/OSX"
  name "Mixing Station"
  desc "Audio Mixer Controller"
  homepage "https://mixingstation.app/"

  livecheck do
    url "https://mixingstation.app/backend/api/web/changelogs/milestones"
    strategy :json do |json|
      json["data"].select { |item| item["variant"] == "Desktop" }
                  .map { |item| item["current"]["version"] }
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  conflicts_with cask: "bevanjkay/tap/mixing-station-beta"

  app "Mixing Station.app"

  zap trash: [
    "~/Library/Saved Application State/org.devcore.mixingstation.pc.savedState",
    "~/MixingStation",
  ]

  caveats do
    requires_rosetta
  end
end
