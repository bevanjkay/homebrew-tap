cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.99"
  sha256 arm:          "35e58c4ee881014fee5d73b3447b5f4283614402a3689581bc7377d503d007ca",
         intel:        "eba3a8fa75ca5c4ab7ffbb38d970fed500af6546f31803f8a8639684a1390fa1",
         arm64_linux:  "54a0d998eee20453fd528c10437ea16b0e2e564dec7d32b0afede6a9778e7a1a",
         x86_64_linux: "7e45e618dc2805d76648dfd7e83da98305ef2c6340099070f329a2d1cde6e858"

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
