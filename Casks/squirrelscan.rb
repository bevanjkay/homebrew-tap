cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.191"
  sha256 arm:          "85cbf43d1f2202d4f37260c609722b698bee442b278cce3a9889fd6dc8b363d6",
         intel:        "c078014bad711191891475e891dd1dfd1e1a707cfc0fb7635b6f828aa75cf8e7",
         arm64_linux:  "0b87c376fd6a80a6f31686ddc8cfa104351e890f77e5218ab74bb36f635316db",
         x86_64_linux: "fe84166988558db3056fbb748f2b2568822b4eea8c56f15c3e881c08a00b78cd"

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
