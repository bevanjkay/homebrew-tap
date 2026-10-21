cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.123"
  sha256 arm:          "c00d8d2d38128c68ffd6fe4f6cdc519f64f5c4be2edeb642f72cd2c687982cba",
         intel:        "80037666a790a97f5f3e27ccbfc152d3111d726b957b71f72e7d95fc2e0b817e",
         arm64_linux:  "7a44f6a2c6297ba614d274a64bf71a6b8c88b08dcf6b8cb3d471ffade37bb80c",
         x86_64_linux: "c5d6aae70b33bbd163dd04ac6b5b70f5c42bb91814baa95c14626d14a5e5e264"

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
