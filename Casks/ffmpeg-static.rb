cask "ffmpeg-static" do
  version "7.1.1"
  sha256 "8d7917c1cebd7a29e68c0a0a6cc4ecc3fe05c7fffed958636c7018b319afdda4"

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
