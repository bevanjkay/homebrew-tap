cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.47"
  sha256 arm:          "3cc04c1d1a787fc543537f1aad2753324e08825529ee4030616f2f1cb0801d23",
         intel:        "c1f72b0aa8e2dfaeddb39eae79709c8566a4471793c9046dd166b27f37d2efd7",
         x86_64_linux: "336bc901f76427a1800fe2f0d6be6f169f024b0ec34267991f9061d690e43e99",
         arm64_linux:  "0575c322b27c9f22099a1d5bd0809f640a98a6f074b863f0cf2e1600cb0630ad"

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
