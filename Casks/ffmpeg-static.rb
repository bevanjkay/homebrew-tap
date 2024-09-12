cask "ffmpeg-static" do
  version "7.0.2"
  sha256 "33f5f9020de0176ea86850c6738308f338a1e26528a7d96020e45be11132fafd"

  url "https://evermeet.cx/ffmpeg/ffmpeg-#{version}.7z"
  name "ffmpeg"
  desc "Static builds of ffmpeg"
  homepage "https://evermeet.cx/ffmpeg"

  livecheck do
    url :homepage
    regex(/ffmpeg[._-]v?(\d+(?:\.\d+)+)\.7z/i)
  end

  conflicts_with formula: "ffmpeg"

  binary "ffmpeg"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/ffmpeg"
  end

  # No zap stanza required

  caveats do
    requires_rosetta
  end
end
