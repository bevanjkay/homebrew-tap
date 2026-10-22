cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.126"
  sha256 arm:          "ede0d21d0532ef5c08fca5a07ea5d42e9d11499bfea96677b05717714602c54d",
         intel:        "3063adcb800c054345b96ea88e42d3120af0f026912195abc9f119b4fa0ba273",
         arm64_linux:  "fffa2b176ceb62d606b650a7079a77aabf1d33676fd531ff8cebb80fe4993f4a",
         x86_64_linux: "41adbce1c957f0331a887aa51dc09dcc46e22de40e5370c766f4cd78ba3811c2"

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
