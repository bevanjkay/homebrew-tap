cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.130"
  sha256 arm:          "43539c079f7262ad57599ece2b290cc85708094cae0778b2b28072c20850c1f7",
         intel:        "23a522d9014d7330ecc180c22d999bd0499a2452e27e06e530d86e545a38685f",
         arm64_linux:  "b4508345a9d910cf5e01c8aecd9110f88b8763596b6e76bb08a58c893bac4059",
         x86_64_linux: "2c8ca5eab63fef391481e626c8106030383fad81e2b4213e65bf9fd4a2d9764c"

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
