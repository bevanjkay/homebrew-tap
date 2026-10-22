cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.129"
  sha256 arm:          "5a2ade9842f3b1482028f8de370896248c743f5cbf90af898358401f1cad6acb",
         intel:        "d59d3e626d7d7e5f7e5c4bf34323d39caf70bf30fabf4271cb97ed9ad4da37e6",
         arm64_linux:  "e7e1e5f9f18e4f4e6e3b98bc96332a46b7a7305c28477a2de833db5278bb2acc",
         x86_64_linux: "39b2d2e612c59b02cc51e8655a5b8e5f3f1b596d8b7a701fb0b10cc4bacddff3"

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
