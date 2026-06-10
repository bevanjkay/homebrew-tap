cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.39"
  sha256 arm:          "9f58ee816ec39a7db7d2ef2547c58ded170e31aab7ac81a353d5f631ea71e492",
         intel:        "a20c7c1449a05713668d93636d08444683ef7f7837677a2fc10adc1b3ac2b6dd",
         x86_64_linux: "dbb2193216b566dc74608116e3abd7211937f3c85989f9b455e4ddd8420c2b6a",
         arm64_linux:  "f389e0e48f98952d970da0ef28289623c4a08361d00e3110543e19fc6904e1fc"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}",
      verified: "github.com/squirrelscan/squirrelscan/"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
  end

  binary "squirrel-#{version}-#{os}-#{arch}", target: "squirrel"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/squirrel-#{version}-darwin-#{arch}" if OS.mac?
  end

  zap trash: "~/.squirrel"
end
