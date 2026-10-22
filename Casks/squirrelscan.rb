cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.128"
  sha256 arm:          "7802192ead0b57b674e830da8bda208d88420699dcac3f3d7ac4ecdf31a70142",
         intel:        "9b223940ef8147a5ef37aa631baff9cbf2ebe21e542272e22aa9d927714ff9fa",
         arm64_linux:  "ebe88937ccdd3cbb8833b1f3ec01f7a42a97a3d250510bc4a1247d7d8a10fd2b",
         x86_64_linux: "11b5f964404ab1e16a9a48e2dabd4121134c63df65a32412f40c2b167a362d37"

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
