cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.143"
  sha256 arm:          "866ebf181ae68549744201e74638fdba327175102ef2ba7292d7373dc20df37b",
         intel:        "d9cba5a6ec6084e2d345e884e8c07e630d4d0efec51d7eaf88ce7ae57820bdff",
         arm64_linux:  "13ee87fadbb09be21925345755211bfbe71b7e29fea4d6153ed47e6a5a2d0257",
         x86_64_linux: "02d08eed21abc91d0c3e0c486e8dbeb031e1b8e50355f36ecc28b9eb0a81d732"

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
