cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.102"
  sha256 arm:          "ce2ba31b835f5293c4ddbcfc7859abd3d0a77b84ec7ac7ebaa98c1abfce135dc",
         intel:        "a32ab4973db6e6cfdac88fa51d1ad2a51c6caca7cbadf1cec4374e31459e672e",
         arm64_linux:  "ce0ce2346151c36428d8fc0acebae6e82362424509ecb254588a21e6eac1e893",
         x86_64_linux: "742b40647ff796b6d3edad0dcc4d291ec05d4461d6728e257706942d6f181ebd"

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
