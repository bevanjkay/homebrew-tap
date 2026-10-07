cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.105"
  sha256 arm:          "04c98dfc8d9ef004fd454ea48d943eb2df7981268e506bcd23c53bf57cd2d507",
         intel:        "84120f05fdbdf80fa4cb61f45d913ce2b536c41840ceeb64fe35b087f80c2fe4",
         arm64_linux:  "f553d6819482c9b7a463544637ecd5feeda498379d44dda3d4989c887f6309e1",
         x86_64_linux: "1818a2516fc46a1869947d70700a89b0d248cfce2eba89417139bebc2e94725f"

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
