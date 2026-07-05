cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.64"
  sha256 arm:          "6f0f27f4b2943459c485e402b489a94d14f4f7f5e39a7f46c421990597c4125c",
         intel:        "8409a49f4e3dadc61be9b10b6f084f4d1587b2b6f7a00db117ef359564fec310",
         x86_64_linux: "166b25e6e0740753cd67d39b5ab6377bcb1557fb26c73807a0eb8bd626ed9162",
         arm64_linux:  "4152147a8234a8e01fc29c66ed2ce97dec4213ae8c9aa003f1960ac57f3a9cfa"

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
