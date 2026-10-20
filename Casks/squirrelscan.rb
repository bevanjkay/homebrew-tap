cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.119"
  sha256 arm:          "5ce15fde7cd908b2006e81a3703ac582286108a11e270a69916cb1d32c2a5f0d",
         intel:        "55922282d73b8ecaf6c7de8642692e32b8445edf086741bbab3f09dc2ccc152c",
         arm64_linux:  "7af9ce458c64fd4de99b75297b9ecc3eebd3bf433aa9f13e575748c4b449ddf8",
         x86_64_linux: "66d7329239e55f710c35393f6e5f81a10bc0f40c5659c2b47320998a7533e083"

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
