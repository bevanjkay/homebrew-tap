cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.121"
  sha256 arm:          "ce9af4f1135862c72f3ab02f5098c853c7f4762a549d682ea0c5665e8f113dce",
         intel:        "faf1e6a40dffb031af233ffec2fe9fd2cb3f774e1ce6337cadff9ba531ab142f",
         arm64_linux:  "21593911b42fcf53b42893a8c27186601a734d5606b9f670a253eb04b1884564",
         x86_64_linux: "886e5429727613d9130abe4050abe415342fb975460283fcb1cfd34594669089"

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
