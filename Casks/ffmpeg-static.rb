cask "ffmpeg-static" do
  version "8.0"
  sha256 "3bd3f23f12bd84d21a5756efb8c5d841cb4c1d6aac42ea817bf39ec5c602a807"

  url "https://evermeet.cx/ffmpeg/ffmpeg-#{version}.zip"
  name "ffmpeg"
  desc "Static builds of ffmpeg"
  homepage "https://evermeet.cx/ffmpeg"

  livecheck do
    url :homepage
    regex(/ffmpeg[._-]v?(\d+(?:\.\d+)+)\.7z/i)
  end

  binary "ffmpeg"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/ffmpeg"
  end

  # No zap stanza required

  caveats do
    requires_rosetta
  end
end
