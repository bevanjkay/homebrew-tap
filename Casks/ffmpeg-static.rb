cask "ffmpeg-static" do
  version "9.0.2"
  sha256 "4acc0be580f9b2788029eb7bd4d645ff87968911b0a62aeeb3940d42d54558d5"

  url "https://evermeet.cx/ffmpeg/ffmpeg-#{version}.zip"
  name "ffmpeg"
  desc "Static builds of ffmpeg"
  homepage "https://evermeet.cx/ffmpeg"

  livecheck do
    url :homepage
    regex(/ffmpeg[._-]v?(\d+(?:\.\d+)+)\.7z/i)
  end

  binary "ffmpeg"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/ffmpeg"], must_succeed: false
  end

  # No zap stanza required

  caveats do
    requires_rosetta
  end
end
