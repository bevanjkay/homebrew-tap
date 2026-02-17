cask "yt-dlp-static" do
  version "2026.02.04"
  sha256 "e833b5aa657b2f2b8608442e9afac91374f147cb641301e8fb39a339e2fe3f71"

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
