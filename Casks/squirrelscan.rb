cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.51"
  sha256 arm:          "55eabe8670433f492bfdc6cd0e43f2904ea65009eccfb430bb752bd3c3230647",
         intel:        "8ec35ad0070993c8dad0b1fb85df31199652472656aa30f40bb43502fd73172e",
         x86_64_linux: "f725e23266abcc974e0b80f12fd2e05d44e0c081f590f6d62035688a9100b21f",
         arm64_linux:  "dfa3ab98a0f5b9863972fa0133457b495b283fb7e9a661b1f5818f5101bb821e"

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
