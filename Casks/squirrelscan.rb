cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.52"
  sha256 arm:          "ed1b07a6a45a4250bef20f7b241f3a715c83a5b6d8ed0f6990791f957dfaf185",
         intel:        "cef0e4aa15f43e3dc164e9dff8b557285508275682c7310e90bfec4def1a4a68",
         x86_64_linux: "c22c94d1918f9d48d3ff49fe9e0b4096d46115b81c0c33fa0810e5a880e764dc",
         arm64_linux:  "c56b60b487eed3609358a6f4815cc0d8036fc21308c7bf380c791a0c419ca4f0"

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
