cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.125"
  sha256 arm:          "64d1d5f04b9066c81095f5949adeed964a90337960831db92b1e57e777c4d290",
         intel:        "2227a85b9d588dfa922226b1bec749fdf8bb3f3e6849e37b6af4c4b88d2c09d7",
         arm64_linux:  "a10deac404dc21f06b8dcae13d6d267718e75761cc1b24e48c100b9e58609608",
         x86_64_linux: "1db5bfdc706e849c05ef5bc315d27792fd3b2d008147f8fdaf8bb00204f3ba68"

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
