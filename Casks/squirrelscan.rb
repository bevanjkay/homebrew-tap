cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.79"
  sha256 arm:          "003d4d6cbc06d625d2ae1de5acbe693dd9e6bef711b7f1fc678543c82c28548e",
         intel:        "37428a4b86e0902d70fcd8fb90f9006f19136617e9fdfabc7563d9cd6379a9f8",
         x86_64_linux: "e30a416d6180cd8d269fddbc581c39a46815a6ddcadce68bf50817c930888ecb",
         arm64_linux:  "8bb823ce9bc6deec33990ddf9cce0a97c7b47a7b6e680ef9aca542162be56a60"

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
