cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.91"
  sha256 arm:          "55be4cc934679c300aaa70ea1ebd48ab9406454925259fa73cf0acc0f9e94dba",
         intel:        "339186a102087c28c2920539f8cac26527214f46ee760ac06f686ded1519538e",
         arm64_linux:  "b018d685bb9f1a6498af785afc7ccb0a14eb2069137ac65b3ffdd0d5ab298f4f",
         x86_64_linux: "bfcb02a97a7d2f3eaf69c0b0cb8113381d1cc819447550751f6347ddcab5771e"

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
