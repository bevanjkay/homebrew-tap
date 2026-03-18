cask "yt-dlp-static" do
  version "2026.03.17"
  sha256 "e80c47b3ce712acee51d5e3d4eace2d181b44d38f1942c3a32e3c7ff53cd9ed5"

  if OS.not_tier_one_configuration?
    depends_on cask: "bevanjkay/tap/ffmpeg-static"
  else
    depends_on formula: "ffmpeg"
  end

  url "https://github.com/yt-dlp/yt-dlp/releases/download/#{version}/yt-dlp_macos"
  name "yt-dlp-static"
  desc "Feature-rich command-line audio/video downloader"
  homepage "https://github.com/yt-dlp/yt-dlp"

  binary "yt-dlp_macos", target: "yt-dlp"

  # No zap stanza required
end
