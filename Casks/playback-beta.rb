cask "playback-beta" do
  version "7.1.1,7133"
  sha256 "59034c721036b2b490ff019f0e3892476e6ae29cb68853a0fa0023a618ae304f"

  url "https://multitracks.blob.core.windows.net/public/playback/Playback.#{version.before_comma}_#{version.after_comma}.zip",
      verified: "multitracks.blob.core.windows.net/public/playback/"
  name "Playback"
  desc "Multitracks playback beta"
  homepage "https://www.multitracks.com/products/mac"

  livecheck do
    url :homepage
    strategy :page_match do |page|
      page.scan(/href=.*?Playback[._-]v?(\d+(?:\.\d+)+)[._-](\d+)\.zip/i)
          .map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  app "Playback #{version.before_comma} (#{version.after_comma}).app", target: "Playback.app"

  uninstall trash: "~/Library/Containers/com.multitracks.playbackreleasepreview"

  zap trash: [
    "~/Library/Application Support/com.multitracks.playbackreleasepreview",
  ]
end
