cask "yt-dlp-static" do
  version "2025.11.12"
  sha256 "6256eeaaafaeb7c47acdfd5c574a5c77ea7627033728b8c089bbfb7ace475e1f"

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
