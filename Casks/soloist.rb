cask "soloist" do
  arch arm: "arm64", intel: "x86_64"

  version :latest
  sha256 :no_check

  url "https://soloist-builds.spotifycdn.com/soloist_release_#{arch}.tar.gz"
  name "Spotify Soloist"
  desc "CLI for spotify"
  homepage "https://github.com/spotify/soloist"

  depends_on :linux

  binary "soloist"

  # No zap stanza requireds
end
