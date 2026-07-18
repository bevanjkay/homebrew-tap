cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.76"
  sha256 arm:          "0fc41d170445df2844bd3455b6a207cb9127b3c02ec1aafcca6c6b22fd97eb58",
         intel:        "466806f87ca17d9821f74236ea13e80b4253a92a04e301260aa916c2a1081221",
         x86_64_linux: "718aa66d77399f2b62338482c44708321699387e7c699bf706413d436275abe3",
         arm64_linux:  "942c67c1fa9fa70dcdbbda2d3e4a69acc6a876d389e55bdf4ccafa1853b0292f"

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
