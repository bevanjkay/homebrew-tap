cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.122"
  sha256 arm:          "99c7c413d198da82078adc7855121418f84623e4ae79c1b15baeb63699d9637f",
         intel:        "4a5cac03cea3ca3dbe879e1899a307a7101ed75fb3814c665857bd5b1b90a166",
         arm64_linux:  "db406de85877e48f334fa5f3b2c2230235749810e25149129d79975a86a62ca3",
         x86_64_linux: "5fadf563c10492149cc2888d9ae4557004f6765680a0e68ee3caa7d3c3acdf0f"

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
