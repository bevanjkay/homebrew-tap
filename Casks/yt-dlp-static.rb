cask "yt-dlp-static" do
  version "2024.12.03"
  sha256 "10e094f2c9e632e271099967358d91d8db42958728cfc3cb2af55f1f0ee5bc9e"

  on_monterey :or_older do
    depends_on cask: "bevanjkay/tap/ffmpeg-static"
  end
  on_ventura :or_newer do
    depends_on formula: "ffmpeg"
  end

  url "https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp_macos"
  name "yt-dlp-static"
  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"

  binary "yt-dlp_macos", target: "yt-dlp"

  # No zap stanza required
end
