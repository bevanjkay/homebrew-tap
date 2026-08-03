cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.83"
  sha256 arm:          "2bdb125a2a7183207bb59366b2ef292de15de8504dabf2ae7e4dd1a53ba30393",
         intel:        "2168ccfb0cd966d779c5722c666644599d6cbba6ea22b23c2ffcb60a4e922db7",
         x86_64_linux: "f7db3d4c27ae6c90ada9bd204d2c6dc8d33d0d5e4839f51a462f7a3db8affc6d",
         arm64_linux:  "f67665ac888805971b82c3b8233d3a84a74a3656fb32bc078b0330ca3ce81ca3"

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
