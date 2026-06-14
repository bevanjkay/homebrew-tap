cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.46"
  sha256 arm:          "3641d01fa132607906c7bb8a70b2b27b7f323531eaa6d7e248e3beb994dcd31a",
         intel:        "464602b859193b9784ad500015ee62101cbf52882d0881bc9fe54a95eabdd873",
         x86_64_linux: "000b3ad1331ff5a1db8bb4eb835bb5fd310c18fb2d2118a390b9f7dc55138dbc",
         arm64_linux:  "a94f81fc3533099db015d34c33e7a0f0e0af9b8f094eff231644e41608c77ec4"

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
