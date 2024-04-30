cask "mixing-station@beta" do
  version "2.0.3"
  sha256 :no_check

  url "https://mixingstation.app/backend/api/web/download/attachment/mixing-station-pc/beta/OSX"
  name "Mixing Station"
  desc "Audio Mixer Controller"
  homepage "https://mixingstation.app/"

  livecheck do
    url "https://mixingstation.app/backend/api/web/changelogs/milestones"
    strategy :json do |json|
      versions = json["data"].select { |item| item["variant"] == "PC" }
                             .map { |item| item["beta"]["name"] }
      next version if versions.all?(&:blank?)

      versions
    end
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true
  conflicts_with cask: "bevanjkay/tap/mixing-station"

  app "mixing-station-pc.app", target: "Mixing Station.app"

  zap trash: [
    "~/Library/Saved Application State/org.devcore.mixingstation.pc.savedState",
    "~/MixingStation",
  ]
end
