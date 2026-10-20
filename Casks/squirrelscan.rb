cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.118"
  sha256 arm:          "6672f0eacb6b0a1322fef9f66a10fcfa7e3752e433da1797028096894881b2e1",
         intel:        "508f93c3342111196ecaea57fa508c064dde32479124e4f73518b605081cbc52",
         arm64_linux:  "270fede39d13b0521f217184bec85596529d427db9202ff00d033dbc5f5177af",
         x86_64_linux: "0e003ba06745e6257dd60f8a3e8fc77bd5c6a5e65c0feb58df3479a17c29158c"

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
