cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.100"
  sha256 arm:          "1496452094128e07ffe58215f8ceb9cd8928121a6545c1b5f1d2a2da47e9c7a0",
         intel:        "efdf5a296d77160cbc0fc393d665f5111f2b987e599badd9e5e04a62d2475306",
         arm64_linux:  "7e0d7fae41b0eec9436f1783d979c28e795f4da19cd465c2cd86abd7d64e1c51",
         x86_64_linux: "3eedfbe74ce5a9b6f9c286d3d3dc1a5437f216367e320d6bbc6401cc43614273"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
  end

  binary "squirrel-#{version}-#{os}-#{arch}", target: "squirrel"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr",
          args:         ["-d", "com.apple.quarantine", "{{staged_path}}/squirrel-{{version}}-darwin-{{arch}}"],
          must_succeed: false
    end
  end

  zap trash: "~/.squirrel"
end
