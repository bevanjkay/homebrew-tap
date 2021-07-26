cask "b-playback-beta" do
  version "7.1.2,7134"
  sha256 :no_check

  url "https://multitracks.blob.core.windows.net/public/playback/Playback.app.zip",
      verified: "multitracks.blob.core.windows.net/public/playback/"
  name "Playback"
  desc "Multitracks playback beta"
  homepage "https://www.multitracks.com/products/mac"

  livecheck do
    url :url
    strategy :extract_plist
  end

  app "Playback.#{version.before_comma}_#{version.after_comma}.app", target: "Playback.app"

  uninstall trash: "~/Library/Containers/com.multitracks.playbackreleasepreview"

  zap trash: [
    "~/Library/Application Support/com.multitracks.playbackreleasepreview",
  ]
end
