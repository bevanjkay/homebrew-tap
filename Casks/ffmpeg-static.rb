cask "ffmpeg-static" do
  version "7.1"
  sha256 "50a2c54bbd5f92159add3669a081728d0df3fa7ba5fc300c3171bfbeba4a2765"

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
