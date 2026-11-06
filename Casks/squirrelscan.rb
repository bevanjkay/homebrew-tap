cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.170"
  sha256 arm:          "ab29f50c4090bc0652afa7350f1c3c73500f2f7e7e1d89ebec40d862f12c4348",
         intel:        "6cffb4b9113da900608d114b44d75299e440f913b357ab9d57ed9fb90f8544c8",
         arm64_linux:  "7e427fbcbee9fe0acf815557f977fb644b8353a7206ac3a95eccfa698ba59bcd",
         x86_64_linux: "9c7232f574db36b1ae384dc026f64c7f79de918b5285ed37c74098596934426e"

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
