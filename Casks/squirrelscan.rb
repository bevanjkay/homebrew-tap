cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.133"
  sha256 arm:          "930adc171230f632cf5f2e48c3ce891151aa5314979059825fe7615e5dd01aa7",
         intel:        "2fc517f35688ee04df82d23279d353ce372581fc7f675b8f44dcb6c54c0bedc4",
         arm64_linux:  "b77e8e9d1f4c8d451b4ae99080c5668bb3ed398a6ea683511a64513e5f3f7818",
         x86_64_linux: "218640f509db522b54d1d899aac0ebb6a4defb9b045836cf94f10f8b19435465"

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
