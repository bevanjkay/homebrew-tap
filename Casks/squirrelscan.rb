cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.90"
  sha256 arm:          "5d119098b63b6fbc9118bfb319fb0b2bd4debef06b09d2b37809d766a54a1330",
         intel:        "97532f2d01f419c0e78ef1f006757abbc0eed4675cc64ced5f85f1cf735bd02f",
         arm64_linux:  "7d5acbbfd5c31f570c303e06a3a1501c8bd8a5bd970184cc87d656b26306adb3",
         x86_64_linux: "b10a35a7bf07556edfe57db9c091a6d4691df5977ee63c4e4dadbc6af6cbd9d5"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}"
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
