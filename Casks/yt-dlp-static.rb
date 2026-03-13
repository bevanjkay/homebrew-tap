cask "yt-dlp-static" do
  version "2026.03.13"
  sha256 "d27dbb7fd7d8d6af195c8fbf4dce8e3d25e5b474bf088589962468d823e2ee9f"

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
