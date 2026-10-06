cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.104"
  sha256 arm:          "8a3e75df43b582b5844fdb8843584d11748d8f35cd09f36c70b43f41e41b7a99",
         intel:        "4c6e1c1b693ff04fe4b29d188ec6b62fc4ee2b483d304040d06a520a8ab7257f",
         arm64_linux:  "2dc4a7b30f58b80d07e79b75c6af90732b579b3d132f8c7252990837f04e55e2",
         x86_64_linux: "d7d7e4c4c2e9adbe3afd412b90460f6fb98f0b3f890d82bb3d57ef7d8cadf927"

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
