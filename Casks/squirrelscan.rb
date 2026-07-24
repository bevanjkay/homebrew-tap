cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.80"
  sha256 arm:          "61ed89cb65dfca218661e196674d6044601f7ef20c6747325953aa5a915628c9",
         intel:        "880527e85bf2b9b8da1791894c1f5fb06a0c5cae8bf1d96a6f9aa6c7e59e6d2d",
         x86_64_linux: "b08eb287bd2b373c6e4f062fcbd72dfe19718edff04bfe2cade502c256d5382e",
         arm64_linux:  "b5e614b973922b6fa2d0c897bae4e1502544a97235bd9dd5414a548b8c0a3f31"

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
