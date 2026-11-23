cask "ffmpeg-static" do
  version "9.1"
  sha256 "9962f7b3c01af9ac89673c91df9ef998343a280ac0857c295e2d2a301820598a"

  url "https://evermeet.cx/ffmpeg/ffmpeg-#{version}.zip"
  name "ffmpeg"
  desc "Static builds of ffmpeg"
  homepage "https://evermeet.cx/ffmpeg"

  livecheck do
    url :homepage
    regex(/ffmpeg[._-]v?(\d+(?:\.\d+)+)\.7z/i)
  end

  depends_on :macos

  binary "ffmpeg"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "com.apple.quarantine", "{{staged_path}}/ffmpeg"], must_succeed: false
  end

  zap :not_required

  caveats do
    requires_rosetta
  end
end
