cask "decimator-ucp" do
  arch arm: "ARM", intel: "Intel"

  version "3.0.6"
  sha256 arm:   "b105b11ddb93e114505a54ec2f0ea9e1d44c013ae83e2a7cc6f3f24cc4ad5d18",
         intel: "61e8d2ea597a4a5f692c446d74b45bcd8fb65057baa9d3cc062ba012c663aaef"

  url "http://decimator.com/specs/UCP%20#{version}%20#{arch}.dmg"
  name "Decimator USB Control Panel"
  desc "Utility to control and update Decimator Converters"
  homepage "http://decimator.com/"

  livecheck do
    url "http://decimator.com/DOWNLOADS/DOWNLOADS.html"
    regex(/href=.*?UCP[ ._-]v?(\d+(?:\.\d+)+)[ ._-]#{arch}\.dmg/i)
  end

  depends_on macos: :big_sur

  app "UCP #{version} #{arch}.app", target: "Decimator UCP.app"

  # No zap stanza required
end
