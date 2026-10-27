cask "squirrelscan" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "0.0.137"
  sha256 arm:          "9bccb48e7af6db1b54aebe4455fa79dda6afa3905efe7bd7bbb04d0188de6740",
         intel:        "840ac4dd697183912d983e11f8192c6c773b4c71275b8cce1a63c33cdc350687",
         arm64_linux:  "466ac454cb74eb3a07957b8bd84106ebe603d4376cc66b0104d88cd7798cb56d",
         x86_64_linux: "1a99be425eac6533e3c3b36d74712b3c299b5563e8a38cb74ed3329996367cb7"

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
