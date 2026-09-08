cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.92"
  sha256 arm:          "06c631d781631780361c8c4005f8a92775299734c7366fe95d7014e66e7b552f",
         intel:        "3e092772f11ca702d69facfc72b7740bd8a99e7bb0576e1944688005bf2236de",
         arm64_linux:  "36317a6928d3bce30a7e71e70cad204a72862f280186cb0fe9ba36e76a7388ca",
         x86_64_linux: "9e8efc9b2acbee95217f598013a925cefe2f9d84a357111708cbe50a854076e5"

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
