cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.89"
  sha256 arm:          "af0284feaf6eba50a3f96f87346345097b3fe3518adceca5dedd4d5090f0bdd6",
         intel:        "ed0db5ce57a1ba0efc6c24601834ae001fc3ce2832ffa2ee861f58d77bafa9b0",
         arm64_linux:  "cdb7de20b1936058f772c046843cd827ee5be97c3a70b461794619e74b6d163f",
         x86_64_linux: "3eb886538c96ff5e8da3859dd391d71cf32365319bca74ef463fcaaf23c5ba81"

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
