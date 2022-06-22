cask "boom-3d-audio-component" do
  version "1.0"
  sha256 "ab05b0e94472f2f1d373adedd5e3a72a5552a5083af0377cfe68b4edc8ea2fcc"

  url "https://d3jbf8nvvpx3fh.cloudfront.net/device-assets/boom3d/catalina/Boom3d_Audio_Component_Installer.zip"
  name "Boom 3D Component Installer"
  desc "Component installer for Boom 3D"
  homepage "https://www.globaldelight.com/boom3d"

  livecheck do
    url :url
    strategy :extract_plist
  end

  app "Audio Component Installer.app"

  installer manual: "Audio Component Installer.app"

  postflight do
    system "open", "/Applications/Audio Component Installer.app"
    system "rm", "/Applications/Audio Component Installer.app"
  end
end
