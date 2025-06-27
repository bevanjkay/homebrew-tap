cask "decimator-ucp" do
  arch arm: "ARM", intel: "Intel"

  version "3.0.3"
  sha256 arm:   "185cf47b55f5c2892d0092692a1f19db013209e3bf38b6e0aaf90625ed15ddd7",
         intel: "d9ef6767323fc78cc5cb10180857e84dfc4a8cf381fffbdff24d97c611aed882"

  url "http://decimator.com/specs/UCP%20#{version}%20#{arch}.dmg"
  name "Decimator USB Control Panel"
  desc "Utility to control and update Decimator Converters"
  homepage "http://decimator.com/"

  livecheck do
    url "http://decimator.com/DOWNLOADS/DOWNLOADS.html"
    regex(/href=.*?UCP[ ._-]v?(\d+(?:\.\d+)+)[ ._-]#{arch}\.dmg/i)
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  app "UCP #{version} #{arch}.app", target: "Decimator UCP.app"

  # No zap stanza required
end
