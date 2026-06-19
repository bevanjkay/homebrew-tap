cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.55"
  sha256 arm:          "9a762535e5e36baaad7b6c56241435888363b4c1d6d10cb83e66d977c307040c",
         intel:        "6a24f0aa8d136cf20e181f87486d7f63e9852e67fc5ae0f3ae5032b33c1e49aa",
         x86_64_linux: "615bf76c3906be7320b7dd68558abf5d3b66d739d3cbeeea2a769baa5a530d56",
         arm64_linux:  "4c3507438af06765443a92e0bf9e0347b0a64c5c8bc2a7bfcf4b5f05115f4d92"

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
