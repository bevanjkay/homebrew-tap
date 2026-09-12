cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.95"
  sha256 arm:          "d534848dddaf636bf33d5df7cae960ed424f8aacf4d4acc491d3ff2719dd66ee",
         intel:        "09a7d31fde738db2447ff4f4f3167b88258c2d75dfe0ce6b9dd62b6b6d7c9947",
         arm64_linux:  "3dafdbbcf6290fcf765b28ddd6956ad413ba08381e63dc00bb6052f3beb97841",
         x86_64_linux: "8cac82bac4c6e966d2b253e3b16780a211346aeab2a25bdf75b0e1668e8637f8"

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
