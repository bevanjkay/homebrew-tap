cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.132"
  sha256 arm:          "a41c6e15bd07262455106114aef62e811a620215f874ff12312c63c84d1fefe4",
         intel:        "2e53fa704152df02b3a77f94680efeab3213517b61d1be267e8c014fda07b056",
         arm64_linux:  "4e26668a32cbf34581bbc069863e996d3fd5de727bf020601907c3c88cd090a7",
         x86_64_linux: "584fa2810af81940bc95124fb5e11635c68a799d9be5a8c566c5bdb541d77ec9"

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
