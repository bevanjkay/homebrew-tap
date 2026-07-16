cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.74"
  sha256 arm:          "2983b3932045343645796dd205c0c93cb15c102c537ddff17769467b42113744",
         intel:        "1fcff99a7f7773530ef148c43e421b391137dd077dcb8d6d40cb582c466ec77f",
         x86_64_linux: "c9f5c682585dbcd3f51ab5ef7e07d51c8be198bfbc42a06cb234544974f9ee8f",
         arm64_linux:  "f473402a5b00d8c39dc50c9d9af1e9dd31e86425d7dc3905bca5fc42f0b3d7f0"

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
