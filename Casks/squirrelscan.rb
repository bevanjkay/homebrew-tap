cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.109"
  sha256 arm:          "b8cf77e912940181ea9d9076573042eace8e0d9fb9320645778fb4e3800ea218",
         intel:        "4c99fc13747017cf58eb3a21f782eed27d3310de7bd990c4a518eb489098a755",
         arm64_linux:  "fe00d761c3d78d454fbc685ea886fa7a988ab2cf19344ba52f244f032fcd0a46",
         x86_64_linux: "9237f38a4635c9f4c4a45a6cadb261092539a249edbe82a0bb677beadf0a5433"

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
