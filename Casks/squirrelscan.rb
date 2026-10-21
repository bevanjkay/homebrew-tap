cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.124"
  sha256 arm:          "b9406accada1c1f52431b38dfcd29d4b066e763046ac7f85cf122acf4d218cea",
         intel:        "5e248a98da18c93f37f612384a213f4e6708e957b7e1c3e11b7ac30b4f4a2e03",
         arm64_linux:  "4ea60e12cf61b5a6d3421991781524d05e55d9ba605b0534b3e5401decf7e9e6",
         x86_64_linux: "a0123f9bbabcf898a0fab62c5189354a6d9f0d06d26a60ecf1f0186408617848"

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
