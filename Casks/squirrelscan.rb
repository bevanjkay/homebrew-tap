cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.56"
  sha256 arm:          "bf32f2d41161c268a4dd7457e4b685782392567bad027c616862b494b64c7c2d",
         intel:        "a54e3d8c977047a855b5385c28623801203ee895e3b7317852bf01abdf1271c6",
         x86_64_linux: "2f2ce2e0b8e89244f61f424f243b315ce778c181327e4f07474a8752cffdb767",
         arm64_linux:  "067599b087404fb679203d012c51a59f277387e2506d012b97e3b672e05e12f9"

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
