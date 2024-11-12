cask "yt-dlp-static" do
  version "2024.11.04"
  sha256 "14829d7aea733e991b3ff8d098dbf5ec3bf5825b6fc6bf62edee62362c9704e7"

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
