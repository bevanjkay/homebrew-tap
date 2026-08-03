cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.84"
  sha256 arm:          "0743ef1903983053284e3e2c66c44fea1bc42e29cb2ebf943e05db27c034520c",
         intel:        "87e4616ab75640c9ed638f395d5080784a6b26b983c50dfa5bfaf376323766b4",
         x86_64_linux: "acf082d913690e25e1742144e560e4b10ec50ab40ab4dc6aa8c6800e115d23f7",
         arm64_linux:  "5c6cba0818218bfe5b5fe3acae2af3ac773900a405912fafb074ff964ed735eb"

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
