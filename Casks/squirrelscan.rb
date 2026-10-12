cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.110"
  sha256 arm:          "7f61e053801596ac4835d521ccf836272a0ee08d0ce050817fcac95c1d169896",
         intel:        "b7b7cf75f68625b1efe64f18f478659c4ce6b5df2e82f9f112d338bcb912eef0",
         arm64_linux:  "f5a787d4800bf13c8155755ed3bab86bcb028b21860e35908a5087da94cb559a",
         x86_64_linux: "41e7bb1885cbf76cd7b53eafd4855f139a3b7dacab376cb0b20aa8210afd6a53"

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
