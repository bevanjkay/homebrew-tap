cask "boom-3d-audio-component" do
  version "1.0"
  sha256 :no_check

  url "https://d3jbf8nvvpx3fh.cloudfront.net/device-assets/boom3d/catalina/Boom3d_Audio_Component_Installer.zip",
      verified: "d3jbf8nvvpx3fh.cloudfront.net/device-assets/boom3d/"
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
    system "rm -r", "/Applications/Audio Component Installer.app"
  end

  uninstall trash: "/Applications/Audio Component Installer.app"
end
