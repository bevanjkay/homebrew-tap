cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.88"
  sha256 arm:          "2e5464aa608462e3e6b1f197a9ca2653169e28648441623aa222c2b6fe8d2a0c",
         intel:        "cb3e96ed1d1cb8260ba2aafeec27e4ae3d31acfe55dbddeab1e1327e55b01d4d",
         arm64_linux:  "6555645b1d2d48094c0b358db6d9fc37eb51f57eb691da0affaa275464486df9",
         x86_64_linux: "ec5c64e1c41dbea96a2e5d30c35492e049a37351eaf5e5b0bfc8f1708db254cb"

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
