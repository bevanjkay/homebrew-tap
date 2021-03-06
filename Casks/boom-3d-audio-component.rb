cask "boom-3d-audio-component" do
  version "1.3.004"
  sha256 :no_check

  url "https://d3jbf8nvvpx3fh.cloudfront.net/device-assets/boom3d/catalina/latest_v1.3.11_onwards/Audio%20Component%20Installer.zip",
      verified: "d3jbf8nvvpx3fh.cloudfront.net/device-assets/boom3d/"
  name "Boom 3D Component Installer"
  desc "Component installer for Boom 3D"
  homepage "https://www.globaldelight.com/boom3d"

  livecheck do
    url :url
    strategy :extract_plist
  end

  app "Audio Component Installer.app"

  postflight do
    system "open", "/Applications/Audio Component Installer.app"
    system "rm -r", "/Applications/Audio Component Installer.app"
  end
end
