cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.183"
  sha256 arm:          "f4d7b2a7c8d80af764f0e85b34266a5f421a221d87af314cd1d5663d9b4a5e56",
         intel:        "e8f6305bc61c0b3ee4dc3ab83bac2a1824a60f4531cc14a5eedb9bebbb4aaeb4",
         arm64_linux:  "ae8cf7c0f4282d1dc28af9202303cf168e643c7b19b4a77b2f29e96c1c09cd46",
         x86_64_linux: "1cc2a1224ced9908e4ca574ea8bfd7ba57e6cb8b5591fdfa27e09be4be8487b6"

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
