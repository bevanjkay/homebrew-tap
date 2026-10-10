cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.108"
  sha256 arm:          "bd0246c3b009c86b898c47b2891111a12de6ed10295574a91918f76dcb342294",
         intel:        "007a38cae954c8f19bd97ef2a445e1ebd0d16f3737d8424e12a5249cf0529bc1",
         arm64_linux:  "1deafa83dc3822a96688c6200ab7a47dc95b4faf7e2a06c4190400e0518e7698",
         x86_64_linux: "bedfb6b94b86144b5310b33c4c8022f748a97ad7a1c9b007ab01f08e953e5d11"

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
