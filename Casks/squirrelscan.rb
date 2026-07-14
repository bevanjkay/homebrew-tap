cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.71"
  sha256 arm:          "beeb28fdaaa53231dec0f328bea1db22e90b67305d8d61b22a2f466bd26674f8",
         intel:        "f4289f50f9130006aca5816732b55bd5c87cb5b55e823e86fe03f4eeb5b30ae2",
         x86_64_linux: "9f54e5c1f1ece54ad3b95bf32e85beb357615dcafc197e84f4fbddb6e5614151",
         arm64_linux:  "d7a4b804cc1f47905d9ed9e626aff2cf25579df3260859a5a3e08274318dc5f5"

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
