cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.68"
  sha256 arm:          "643080d2e3df78f7701ef6f387e46f342f9086286295a0b2e0611611237847df",
         intel:        "66c4310e2b530379a1d75fb7169649d906df417d78071c61873edfa7a516fa69",
         x86_64_linux: "1d455aa5a0ac3d2a491590e8953134a16235d19f880a8db2de02d8fa4a2e46e2",
         arm64_linux:  "2c4c24d124fa5a04bf9bfd218df59113a89786e519bde077d74ff6e73dcc17a9"

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
