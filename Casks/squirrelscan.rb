cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.82"
  sha256 arm:          "49c7b8f072762fbe6e71156fece0d921ff627caf7c0ee188df4cdc80d23fada9",
         intel:        "eb96baf5d656a09359388905fe43cb3cb45d23025acea89e3a3b53ab36c5d478",
         x86_64_linux: "f8277ca616ed8bb01d9d344e327f45d40490c2c36e3924e6ae9127ddfd3780ac",
         arm64_linux:  "182f02a67c1c0cc14f1aaa583f5f79ca25bd0b954a07fdaae220cc379e3b42f1"

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
