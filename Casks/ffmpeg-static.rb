cask "ffmpeg-static" do
  version "7.1"
  sha256 "5a1303c7babaffff3c32c141ff49c7f44bd3b3b3e7dcea992fd7d04b6558ef43"

  url "https://evermeet.cx/ffmpeg/ffmpeg-#{version}.zip"
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
