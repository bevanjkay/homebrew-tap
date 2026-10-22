cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.127"
  sha256 arm:          "fa23060c57dd7d9634b27aff1dd3985714bf3e86daff26af8a7f1f658155da8c",
         intel:        "bdf78011acbeadb8d07055fa478a037e53f5f0a577aed90a4103ce3d4fe3ce0c",
         arm64_linux:  "17cf20d6bb0e77e51f5f839714b3d7774954704c7bb75ebcd0fc4ac22d92849a",
         x86_64_linux: "bd68382f327efcc822a16ea1dfa64a01eafb6577e54a2783c67c4cd69c22974f"

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
