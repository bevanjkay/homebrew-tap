cask "yt-dlp-static" do
  version "2024.10.07"
  sha256 "8265ca802d67202b660752198fb0284aa5a115c5c9c518951964c853747a5219"

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
