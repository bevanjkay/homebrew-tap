cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.93"
  sha256 arm:          "307403cd7355d0bfbf49ba19958bf7fb7ad934392c4c1e9922f544e385150054",
         intel:        "30a5c2f8ee7620c38cce95f530ac12c782abc464f1cc4483bd3e61f5c3d5b20d",
         arm64_linux:  "0916fd63329ace8fe0410f8ac9853407c978920fdb5274c81b6c3b1442faa109",
         x86_64_linux: "34abbf52d24ee91c069272464ba0de902f1f9701940577566fa14c6569a8b809"

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
