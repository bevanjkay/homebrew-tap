cask "decimator-ucp" do
  arch arm: "ARM", intel: "Intel"

  version "3.0.4"
  sha256 arm:   "2a9c6971f9f011270645cb04c818de98c7caae97fd2923550db535c79ab1feb3",
         intel: "be3b38c2dea817e29df545c85b2f2d49d5ac70b8fc8fd01de896891d465ec352"

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
