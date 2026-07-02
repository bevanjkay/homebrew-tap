cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.62"
  sha256 arm:          "83a2d6e15a4dde76407e6f8dbd0a3669ef1413a7886b5388a123fb519270cad1",
         intel:        "bdaf3ec60557482b6c6dd94e91e8bcc4f0fe20c17bcab4a763632e2e62695213",
         x86_64_linux: "5e15f57782c29dfb4cc36a23648c4a171f477f8fa2ec37654851a23d22c6d002",
         arm64_linux:  "a29df92ec92fbb1c1c3f3d9b57dc887ac787080b550389f0d705e9c36d27763c"

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
