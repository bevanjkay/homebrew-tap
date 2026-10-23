cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.131"
  sha256 arm:          "80fe67e2d395b3876da08e4d4ab5c69fe0bc76f9392098d8e0041c34b435ec30",
         intel:        "47c0577d213f470df4d4eae9ef4801fe941e6542d41025a9774a5c9e1de64fcf",
         arm64_linux:  "9524dd7bead7cd2a35b36861b4b2c73933dce1a7b3d24b0b47dd4b03be355340",
         x86_64_linux: "1e03c9a5835e72c188af01f0afa273699dfa2e16c576b060dcaaa6b1cda2df0c"

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
