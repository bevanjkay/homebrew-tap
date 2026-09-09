cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.94"
  sha256 arm:          "9ccfb658e573eda7430a39c03055988c03fea2da9f338d82cd71d9abed590a3a",
         intel:        "4976f2ace974d5eb16e669c06a31fc93085c40875afe4af3a848abc8b9aa7e3f",
         arm64_linux:  "e2d92b5fe492a2f1d5803e95c42ddf315f6a4330c939b1076d8af011e50a6518",
         x86_64_linux: "75c268a664a8cfff8c19ffd13b279210e93e2410a42b765fb31b7c962da14b82"

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
