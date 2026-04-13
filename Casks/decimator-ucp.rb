cask "decimator-ucp" do
  arch arm: "ARM", intel: "Intel"

  version "3.0.5"
  sha256 arm:   "17c00f10e4125bc6c646508b34f838eb6d29d5b24237107759bc38b4f40ad8b2",
         intel: "9913706d90b0bf62ecc75b51fa06058c18f5cf34c7734ac38c65c7e3f655bb33"

  url "http://decimator.com/specs/UCP%20#{version}%20#{arch}.dmg"
  name "Decimator USB Control Panel"
  desc "Utility to control and update Decimator Converters"
  homepage "http://decimator.com/"

  livecheck do
    url "http://decimator.com/DOWNLOADS/DOWNLOADS.html"
    regex(/href=.*?UCP[ ._-]v?(\d+(?:\.\d+)+)[ ._-]#{arch}\.dmg/i)
  end

  depends_on macos: ">= :big_sur"

  app "UCP #{version} #{arch}.app", target: "Decimator UCP.app"

  # No zap stanza required
end
