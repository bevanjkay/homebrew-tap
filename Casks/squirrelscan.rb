cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.65"
  sha256 arm:          "2e537eaf54329b6a90dd5b2ac43e6989a93f49dba1626f81c0ad5901f34c5fde",
         intel:        "9227785d26cb956a4bde6681faa2d749c71e1a7ff257040c8410fcaf308a8232",
         x86_64_linux: "3e32278ced40974b8e8cb14a38475d5b79cf9f25a09b71c8f8623a868e932221",
         arm64_linux:  "df587bb4447576252fdde3aa04a935e78abef32d7a636a3012e715b632b4fd1d"

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
