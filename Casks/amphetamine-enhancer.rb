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

  depends_on macos: ">= :high_sierra"

  app "Amphetamine Enhancer.app"

  caveats <<~EOS
    #{name.to_s} is a helper application for Amphetamine. It is not a standalone application.
    Amphetamine must be installed from the Mac App Store for #{name.to_s} to work.
      mas install 937984704
  EOS
end
