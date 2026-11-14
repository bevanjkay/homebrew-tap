cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.182"
  sha256 arm:          "4d56b15fe462768753c85dc57ce0e79cf086ea7b4e18924308485789ac0c68ca",
         intel:        "a700f0e53bd7d7be0185ea419df0654c7c6235f3ff6fca7bf60e789d0c916aab",
         arm64_linux:  "31874f131e81cebdeb1444a2e29289fd55b47db78d36d7bb4ec8f61a305403f9",
         x86_64_linux: "c9a5f152c8c2e64c5a04a4a38470ffc9c1612f6ae0909b5f5f81c79215bc61f9"

  url "https://github.com/squirrelscan/squirrelscan/releases/download/v#{version}/squirrel-#{version}-#{os}-#{arch}"
  name "SquirrelScan"
  desc "Website scanning tool"
  homepage "https://squirrelscan.com/"

  livecheck do
    url "https://squirrelscan.com/download"
    regex(/href=.*?squirrel[._-]v?(\d+(?:\.\d+)+)-#{os}-#{arch}/i)
    throttle days: 3
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
