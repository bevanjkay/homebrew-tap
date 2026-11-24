cask "yt-dlp-static" do
  version "2026.11.23"
  sha256 "57654854886d0398a798895aadf5173e2749fbb5e249b9f3728022ab376e11fb"

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

  zap :not_required
end
