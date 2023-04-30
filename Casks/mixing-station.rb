cask "mixing-station" do
  version "1.8.7"
  sha256 :no_check

  url "https://mixingstation.app/backend/api/web/download/attachment/mixing-station-pc/release/OSX"
  name "Mixing Station"
  desc "Audio Mixer Controller"
  homepage "https://mixingstation.app/"

  livecheck do
    url "https://mixingstation.app/backend/api/web/changelogs/milestones"
    strategy :json do |json|
      json["data"].select { |item| item["variant"] == "PC" }
                  .map { |item| item["current"]["name"] }
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  app "mixing-station-pc.app", target: "Mixing Station.app"

  zap trash: [
    "~/Library/Saved Application State/org.devcore.mixingstation.pc.savedState",
    "~/MixingStation",
  ]
end
