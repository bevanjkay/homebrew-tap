cask "decimator-ucp" do
  arch arm: "ARM", intel: "Intel"

  version "3.0.1"
  sha256 arm:   "092f2cdb303760f6130687348279dc67582103958a736ad5d62ca483e697c6a6",
         intel: "3ddf360c3a821f8ce186d6bc3d2d0c300cd3ca859d90a929afdfe9f1b9b2dced"

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
