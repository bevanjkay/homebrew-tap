cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.85"
  sha256 arm:          "bb7fd5488d0a2d72050c390154abefd8e6ff1006601bd809f52bae96670e3f28",
         intel:        "d5bd9ca82090dfb822075550f4af79097c26e9f29e63ef60b88cab6862d412d6",
         x86_64_linux: "7767c89fbe594890a6b6ca06d44fec6de765dd0c585c2d7fa2684c69daf5b76f",
         arm64_linux:  "15a534140a8f14ee1a8f83cc55ae623b0ae4038f1ebe899e3759490dc8e2941a"

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
