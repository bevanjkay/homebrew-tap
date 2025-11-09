cask "amphetamine-enhancer" do
  version "1.0"
  sha256 :no_check

  url "https://github.com/x74353/Amphetamine-Enhancer/raw/master/Releases/Current/Amphetamine%20Enhancer.dmg"
  name "Amphetamine Enhancer"
  desc "Helper application for Amphetamine"
  homepage "https://github.com/x74353/Amphetamine-Enhancer"

  livecheck do
    url "https://github.com/x74353/Amphetamine-Enhancer/raw/master/Releases/AppCast/Appcast.xml"
    strategy :sparkle
  end

  app "Amphetamine Enhancer.app"

  zap trash: [
    "~/Library/Preferences/com.if.Amphetamine-Enhancer.plist",
    "~/Library/Saved Application State/com.if.Amphetamine-Enhancer.savedState",
  ]

  caveats do
    requires_rosetta
    <<~EOS
      Amphetamine Enhancer is a helper application for Amphetamine. It is not a standalone application.
      Amphetamine must be installed from the Mac App Store for Amphetamine Enhancer to work.
        mas install 937984704
    EOS
  end
end
