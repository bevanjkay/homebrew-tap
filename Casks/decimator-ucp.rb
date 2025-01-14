cask "decimator-ucp" do
  arch arm: "ARM", intel: "Intel"

  version "3.0.2"
  sha256 arm:   "102b2e24d70f56ede11ffa31edccdaf6a1795eb228886e2d4bd221a83cf95ce7",
         intel: "22b13fb0ee473edf5aea8f593d77e0e027db853f8b8351fcbdc5e3bf6ba3387d"

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
