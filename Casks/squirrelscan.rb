cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.86"
  sha256 arm:          "a67fdcfe87e53632e2a4c630dc89c6f108b5e89602d66febab22cab1287d22d4",
         intel:        "01e4fbb0227e0f575e245eb0d8a4fc3b91442fa02bc0c1f6b443e119012d01bc",
         arm64_linux:  "a150e64da3ed33b580c417e0a91601f28cb2ef5942114025f9da3efbefa5c575",
         x86_64_linux: "3433517af8f741afe24d9a7bb7ed0b031555728f2641fa11b62a6a8fe74f1830"

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
