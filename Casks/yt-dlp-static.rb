cask "yt-dlp-static" do
  version "2024.11.18"
  sha256 "3ea2a0c1768b630dfad127239882af4ea60ba6116bca0a6ce64974759eba0005"

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
