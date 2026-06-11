cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.43"
  sha256 arm:          "de8dfa498b763b594c7d66eaca340c4fc4f042d44e98e3c3dc39d92d61e4d5bb",
         intel:        "db2f77c80cdd57e09083a6343349d34d91ab4a47d9cb7f59a657129d1fe97370",
         x86_64_linux: "0107d5f604d3171efd1fd5fc1b08345c919e6b0c6312948f50744b98b7aa037c",
         arm64_linux:  "6f8d0bcbc75cf7c1316f8c81f2a0268799e4bf79bdda22f5d37746c8cf943476"

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
