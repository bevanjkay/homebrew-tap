cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.40"
  sha256 arm:          "f039294f1f78c905e5e0a81e1230bf7b9a09b3d309aa8296b9c14bed3b4f7619",
         intel:        "e7890f5c15e5ef4ec3950468c2b5c184586c6471331d2b1c10e5c02ee8869bb3",
         x86_64_linux: "347be07da6ebb715a8ef9b8b45f06a500d5315c33ee388dc3fd8005239ecc2d0",
         arm64_linux:  "2ee700b5ac1c300f410b1c81a8e9b0392075943a37056d44f47e009c6f79b636"

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
