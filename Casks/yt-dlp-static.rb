cask "yt-dlp-static" do
  version "2026.10.21"
  sha256 "7a6fe71d7d680f1fb0ac18d4949873d77db2859e90017c0f44bd94b23be4ee40"

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
