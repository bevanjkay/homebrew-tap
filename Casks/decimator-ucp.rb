cask "decimator-ucp" do
  version "3.0.0"
  sha256 "4b8a2cc909f89c734dcfea36dd8610cabc2d317f52c56c6a051e15974bbe93c3"

  url "http://decimator.com/specs/UCP%20#{version}.dmg"
  name "Decimator USB Control Panel"
  desc "Utility to control and update Decimator Converters"
  homepage "http://decimator.com/"

  livecheck do
    url "http://decimator.com/DOWNLOADS/DOWNLOADS.html"
    regex(/href=.*?UCP[ ._-]v?(\d+(?:\.\d+)+)\.dmg/i)
  end

  # Doesn't automatically update, but set to true to prevent `brew upgrade` from forcing an update
  auto_updates true

  app "UCP #{version}.app", target: "Decimator UCP.app"

  # No zap stanza required
end
