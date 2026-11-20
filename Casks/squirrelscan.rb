cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.189"
  sha256 arm:          "0bf16e111b5b4b8bd2071bbf7b0a1f7d61b4f056f5d64e8515ea2d94451339aa",
         intel:        "21652a5755accc1ddc2d1ea22c4713c935abf07b64a965d07ec9765e59d85f09",
         arm64_linux:  "062ec1d0655f2395697b6d8e5b28b21f84971e36b02f5a0cdd3c56ba317c05eb",
         x86_64_linux: "be3e4a7022ae24d6ae9f6d8c097778638d19af7ce377a451d5f3d358dcc7c523"

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
