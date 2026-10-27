cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.136"
  sha256 arm:          "2fde6b52e52ec4e881a335d4cc6b7536a71e53bca68d38ded9bdf0dca387efcf",
         intel:        "f97ee35d43690f7663b20209d630583b8c09166b738620f23be77166aff8865c",
         arm64_linux:  "f75bf039c2a457098149aa90a9c109ce6ee9624d81ebff94a277602fe08436bb",
         x86_64_linux: "4837ecb4c0a926fdc9ae223917ce53cab51f111cc418dd36bd7b634d546e1254"

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
